module src.entities.ExportDescriptor;

class ExportDescriptor
{
    import std.stdio;
    import src.instructions.Index;
    
    uint start;
    uint end;
    ubyte typeId;
    string type;
    enum string[ubyte] indexTypes = [0x00: "function", 0x01: "table", 0x02: "memory", 0x03: "global"];
    Index index;

    this(uint start, const ubyte[] wasm)
    {
        this.start = start;
        this.parse(wasm);
    }

    void parse(const ubyte[] wasm)
    {
        this.typeId = wasm[this.start];
        if (!(this.typeId in this.indexTypes))
            throw new Exception("TODO - Add proper error message");
        this.type = this.indexTypes[this.typeId];
        this.index = new Index(this.start + 1, wasm);
        this.end = this.index.end;
    }
}