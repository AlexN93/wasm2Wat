module src.entities.Local;

class Local
{
    import src.utils;
    import src.types.ValueType;
    
    uint start;
    uint end;
    ValueType valueType;

    this(uint start, const ubyte[] wasm)
    {
        this.start = start;
        this.parse(wasm);
    }

    void parse(const ubyte[] wasm)
    {
        auto ulebParsed = Utils.readULEB128(wasm[this.start .. $]);
        uint offcet = this.start + ulebParsed[1];
        this.valueType = new ValueType(offcet, wasm);
        this.end = this.valueType.end;
    }

    // TODO
    string toWatString()
    {
        return "";
    }
}