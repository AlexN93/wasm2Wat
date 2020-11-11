module src.sections.FunctionSection;

import src.sections.Section;
import src.sections.SectionId;

@SectionId(3)
class FunctionSection : Section
{
    import std.conv;
    import src.utils : Utils;
    import src.instructions.Index;
    import src.entities.Code;
    
    Code codeSection;
    Index[] indexes;

    this(uint start, const ubyte[] wasm)
    {
        super(start, wasm, "function");
        this.parse(wasm);
    }

    void parse(const ubyte[] wasm)
    {
        auto ulebParsed = Utils.readULEB128(wasm[this.dataStart .. $]);
        const ulong indexes = ulebParsed[0];
        uint offcet = this.dataStart + ulebParsed[1];
        for (auto i = 0; i < indexes; ++i)
        {
            Index idx = new Index(offcet, wasm);
            this.indexes ~= idx;
            offcet = idx.end;
        }
        this.end = offcet;
    }

    override void toWatString(ref string result, Section[string] sections)
    {
        foreach (i, Index idx; this.indexes)
        {
            string typeData = sections["type"].functionTypes[idx.value].toWatStringForFunction();
            string exportData = sections["export"].exports[idx.value].toWatString();
            string codeData = sections["code"].codes[i].toWatString();
            result ~= text("\n  (func ", exportData, " (type $t", to!string(idx.value), ")",
                typeData, "\n", codeData, ")");
        }
    }
}