module main

import vweb

struct App {
    vweb.Context
}

fn main() {
    app := App{}
    vweb.run(app, 8081)
}

pub fn (mut app App) index() vweb.Result {
    ipynb := parse_ipynb('./sample/sample.ipynb') or {
	IPynb{}
    }
    sources := ipynb.cells.map(it.source)
    ecounts := ipynb.cells.map(it.execution_count)
    mut outputs := [][]string{len: 10000, cap: 10000, init: []string{cap: 10000, init: ''}}
    for i, _ in sources {
	if ipynb.cells[i].outputs.len == 0 {
	    outputs[i] = ['']
	    continue
	}
	outputs[i] = ipynb.cells[i].outputs.map(it.data.text_plain)[0]
    }
    return $vweb.html()
}

