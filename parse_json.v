module main

import os
import json

struct CodeMirrorMode {
    name string
    version int
}

struct LangInfo {
    name string
    version string
    mimetype string
    codemirror_mode CodeMirrorMode
    pygments_lexer string
    nbconvert_exporter string
    file_extension string
}

struct KernelSpec {
    name string
    display_name string
}

struct Interpreter {
    hash string
}

struct Metadata {
    orig_nbformat int
    language_info LangInfo
    kernelspec KernelSpec
    interpreter Interpreter
}

struct OutputData {
    text_plain []string [json:'text/plain']
    text_html []string [json:'text/html']
}

struct Output {
    output_type string
    data OutputData
    // metadata Metadata
    execution_count int
}

struct Cell {
    cell_type string
    execution_count int
    source []string
    outputs []Output
    // metadata Metadata
}

struct IPynb {
    cells []Cell
    // metadata Metadata
    nbformat int
    nbformat_minor int
}

pub fn parse_ipynb(file_name string) ?IPynb {
    s := os.read_file(file_name) ?
    ipynb := json.decode(IPynb, s) ?
    return ipynb
}

