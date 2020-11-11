module src.sections.CodeSection;

import src.sections.Section;
import src.sections.SectionId;

@SectionId(10)
class CodeSection: Section
{
    import src.utils : Utils;
    import src.entities.Code;
    
    this(uint start, const ubyte[] wasm)
    {
        super(start, wasm, "code");
        this.parse(wasm);
    }

    void parse(const ubyte[] wasm)
    {
        auto ulebParsed = Utils.readULEB128(wasm[this.dataStart .. $]);
        const ulong codes = ulebParsed[0];
        uint offcet = this.dataStart + ulebParsed[1];
        for (auto i = 0; i < codes; ++i) {
            Code c = new Code(offcet, wasm);
            this.codes ~= c;
            offcet = c.end;
        }
        this.end = offcet;
    }
}