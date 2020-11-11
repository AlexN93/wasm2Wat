module src.sections.TypeSection;

import src.sections.Section;
import src.sections.SectionId;

@SectionId(1)
class TypeSection : Section
{
    import std.conv;
    import src.utils;
    import src.types.FunctionType;
    
    this(uint start, const ubyte[] wasm)
    {
        super(start, wasm, "type");
        this.parse(wasm);
    }

    void parse(const ubyte[] wasm)
    {        
        auto ulebParsed = Utils.readULEB128(wasm[this.dataStart .. $]);
        const ulong types = ulebParsed[0];
        uint offcet = this.dataStart + ulebParsed[1];
        for (ulong i = 0; i < types; ++i) {
            FunctionType ft = new FunctionType(offcet, wasm);
            this.functionTypes[i] = ft;
            offcet = ft.end;
        }
        this.end = offcet;
    }

    override void toWatString(ref string result)
    {
        foreach (i, FunctionType ft; this.functionTypes)
        {
            result ~= text("\n  (type $t", to!string(i), ft.toWatString(), ")");
        }
    }
}