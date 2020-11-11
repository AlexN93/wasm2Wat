module src.instructions.Index;

class Index
{
    import src.utils : Utils;
    
    uint start;
    uint end;
    ulong value;
    
    this(uint start, const ubyte[] wasm)
    {
        this.start = start;
        this.parse(wasm);
    }

    void parse(const ubyte[] wasm)
    {
        auto ulebParsed = Utils.readULEB128(wasm[this.start .. $]);
        this.value = ulebParsed[0];
        this.end = this.start + ulebParsed[1];
    }
}