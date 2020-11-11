module src.entities.Code;

class Code
{
    import src.utils;
    import src.entities.Function;

    uint start;
    uint end;
    ulong size;
    Function codeFunction;

    this(uint start, const ubyte[] wasm)
    {
        this.start = start;
        this.parse(wasm);
    }

    void parse(const ubyte[] wasm)
    {
        auto ulebParsed = Utils.readULEB128(wasm[this.start .. $]);
        this.size = ulebParsed[0];
        this.codeFunction = new Function(this.start + ulebParsed[1], this.size, wasm);
        this.end = this.codeFunction.end;
    }

    string toWatString()
    {
        if (!this.codeFunction)
            return "";
        return this.codeFunction.toWatString();
    }
}