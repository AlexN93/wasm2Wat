module src.types.ValueType;

class ValueType
{
    import std.stdio;
    
    uint start;
    uint end;
    string type;
    ubyte typeId;
    enum string[ubyte] valueTypes = [0x7F: "i32", 0x7E: "i64", 0x7D: "f32", 0x7C: "f64"];

    this(uint start, const ubyte[] wasm)
    {
        this.start = start;
        this.parse(wasm);
    }

    void parse(const ubyte[] wasm)
    {
        this.typeId = wasm[start];
        if (!(this.typeId in this.valueTypes))
            throw new Exception("TODO - Add proper error message");
        this.type = this.valueTypes[this.typeId];
        this.end = this.start + 1;
    }
}