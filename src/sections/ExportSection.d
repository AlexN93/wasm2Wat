module src.sections.ExportSection;

import src.sections.Section;
import src.sections.SectionId;

@SectionId(7)
class ExportSection: Section
{
    import std.regex;
    import src.utils : Utils;
    import src.entities.Export;

    this(uint start, const ubyte[] wasm)
    {
        super(start, wasm, "export");
        this.parse(wasm);
    }

    void parse(const ubyte[] wasm)
    {
        auto ulebParsed = Utils.readULEB128(wasm[this.dataStart .. $]);
        const ulong exports = ulebParsed[0];
        uint offcet = this.dataStart + ulebParsed[1];
        for (auto i = 0; i < exports; ++i) {
            Export e = new Export(offcet, wasm);
            this.exports[e.exportDescriptor.index.value] = e;
            offcet = e.end;
        }
        this.end = offcet;
    }
}