module src.types.FunctionType;

class FunctionType
{
    import std.stdio;
    import std.conv;
    import src.utils;
    import src.types.ValueType;

    uint start;
    uint end;
    ValueType[] valueTypes;
    ValueType[] resultTypes;
    
    this(uint start, const ubyte[] wasm)
    {
        this.start = start;
        this.parse(wasm);
    }

    void parse(const ubyte[] wasm)
    {
        const ubyte magic = wasm[this.start];
        if (magic != 0x60)
            throw new Exception("TODO - Add proper error message");

        uint offcet = this.start + 1;
        // arguments
        auto ulebParsed = Utils.readULEB128(wasm[offcet .. $]);
        const ulong params = ulebParsed[0];
        offcet += ulebParsed[1];
        for (auto i = 0; i < params; ++i) {
            ValueType vt = new ValueType(offcet, wasm);
            this.valueTypes ~= vt;
            offcet = vt.end;
        }

        // returns
        ulebParsed = Utils.readULEB128(wasm[offcet .. $]);
        const ulong results = ulebParsed[0];
        offcet += ulebParsed[1];
        for (auto i = 0; i < results; ++i) {
            ValueType vt = new ValueType(offcet, wasm);
            this.resultTypes ~= vt;
            offcet = vt.end;
        }

        this.end = offcet;
    }

    string toWatString()
    {
        string result = "";
        if (!this.valueTypes.length && !this.resultTypes.length)
            return result;
        
        result ~= " (func";
        if (this.valueTypes.length) {
            result ~= " (param";
            foreach (i, ValueType vt; this.valueTypes) {
                result ~= text(" " ~ vt.type);
            }
            result ~= ")";
        }
        
        if (this.resultTypes.length) {
            result ~= " (result";
            foreach (i, ValueType rt; this.resultTypes) {
                result ~= text(" ", rt.type);
            }
            result ~= ")";
        }
        result ~= ")";
        
        return result;
    }

    string toWatStringForFunction()
    {
        string result = "";
        if (!this.valueTypes.length && !this.resultTypes.length)
            return result;

        if (this.valueTypes.length) {
            foreach (i, ValueType vt; this.valueTypes) {
                result ~= text(" (param $var", to!string(i), " ", vt.type, ")");
            }
        }

        if (this.resultTypes.length) {
            foreach (i, ValueType rt; this.resultTypes) {
                result ~= text(" (result ", rt.type, ")");
            }
        }

        return result;
    }
}