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
    for cell in ipynb.cells {
	println('$cell.source')
    }
    sources := ipynb.cells.map(it.source)
    ecounts := ipynb.cells.map(it.execution_count)
    // println('$ipynb.metadata')
    println('')
    return $vweb.html()
}

