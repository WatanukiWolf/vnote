module main

fn main() {
    ipynb := parse_ipynb('./sample/sample.ipynb') or {
	return
    }
    for cell in ipynb.cells {
	println('$cell.source')
    }
    // println('$ipynb.metadata')
    println('')
}

