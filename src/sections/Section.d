module src.sections.Section;

static class Section
{
    import src.utils;
    import src.types.FunctionType;
    import src.entities.Code;
    import src.entities.Export;
    
    string type = "section";
    uint sectionId;
    uint start;
    uint end;
    uint dataStart;
    ulong dataSize;

    FunctionType[ulong] functionTypes;
    Export[ulong] exports;
    Code[] codes;
    
    this() {}

    this(uint start, const ubyte[] wasm, string type)
    {
        this.type = type;
        this.parse(start, wasm);
    }

    public void parse(uint start, const ubyte[] wasm)
    {
        this.start = start;
        this.sectionId = wasm[this.start];
        auto ulebParsed = Utils.readULEB128(wasm[this.start + 1 .. $]);
        this.dataSize = ulebParsed[0];
        this.dataStart = this.start + ulebParsed[1] + 1;
    }

    void toWatString(ref string result) {}
    void toWatString(ref string result, Section[string] sections) {}
}

