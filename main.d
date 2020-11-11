module main;

import std.stdio;
import std.regex;
import src.wasm2wat : Wasm2Wat;

// TODO - add the remaining Sections and the logic for them
// TODO - should be possible to multithread the processing of different sections
// TODO - add proper error handling try/catch
// TODO - add validation of input data
string wasm2Wat(const ubyte[] wasm)
{
    Wasm2Wat wasm2Wat = new Wasm2Wat(wasm);
    if (!wasm2Wat.validateMagic()) {
        throw new Exception("Error - Magic is invalid");
    }
    wasm2Wat.populateSections();

    return wasm2Wat.getSectionsWat();
}

void main() {
    const ubyte[] wasm = [0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00,
    0x01, // section id(Type)
    0x07, // section size(7)
    0x01, // num types(1)
    0x60, 0x02, 0x7f, 0x7f, 0x01, 0x7f, // ftype 0 (param i32, i32) (result i32)  

    0x03, // section id(Function)
    0x02, // section size(2)
    0x01, // num functions
    0x00, // function 0 signature index
    
    0x07, // section id(Export)
    0x0a, // section size(10)
    0x01, // export count
    0x06, // "addTwo".length
    0x61, 0x64, 0x64, 0x54, 0x77, 0x6f, // "addTwo" - export name
    0x00, // export kind [0x00: "function", 0x01: "table", 0x02: "memory", 0x03: "global"]
    0x00, // export func index 
    
    0x0a, // section id(Code)
    0x09, // section size(9)
    0x01, // num functions
    0x07, // func body size
    0x00, // local decl count
    0x20, 0x00, // local.get local index
    0x20, 0x01, // local.get local index
    0x6a, // 0x6a
    0x0b, // END

    0x00, // section id(Custom)
    0x1d, // section size(29)
    0x04, // "name".length
    0x6e, 0x61, 0x6d, 0x65, // custom section name
    
    0x01, // function name type
    0x09, // sub section size(9)
    0x01, // num functions
    0x00, // function index
    0x06, // "addTwo".length
    0x61, 0x64, 0x64, 0x54, 0x77, 0x6f, // func name
    0x02, // local name type
    
    0x0b, // sub section size(11)
    0x01, // num functions
    0x00, // function index
    0x02, // num locals
    0x00, 0x02, 0x70, 0x30, // local p0
    0x01, 0x02, 0x70, 0x31]; // local p1

    const string wat = wasm2Wat(wasm);
    writeln(wat);
}