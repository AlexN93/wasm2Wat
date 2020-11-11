module src.entities.Function;

class Function
{
    import std.stdio;
    import src.entities.Local;
    import src.instructions.Expression;
    import src.utils;

    uint start;
    uint end;
    ulong size;
    Local[] locals;
    Expression expression;

    this(uint start, ulong size, const ubyte[] wasm)
    {
        this.start = start;
        this.size = size;
        this.parse(wasm);
    }

    void parse(const ubyte[] wasm)
    {
        auto ulebParsed = Utils.readULEB128(wasm[this.start .. $]);
        uint offcet = this.start + ulebParsed[1];
        const ulong locals = ulebParsed[0];
        for (auto i = 0; i < locals; ++i) {
            Local l = new Local(offcet, wasm);
            this.locals ~= l;
            offcet = l.end;
        }
        this.end = this.start + cast(uint)this.size;
        
        this.expression = new Expression(offcet, this.end, wasm);
        if (this.expression.end != this.end) 
            throw new Exception("TODO - Add proper error message");
        if (wasm[this.expression.end-1] != 0x0b)
            throw new Exception("TODO - Add proper error message");
    }

    string toWatString()
    {
        // TODO - include locals printing

        if (!this.expression) 
            return "";
        return this.expression.toWatString();
    }
}