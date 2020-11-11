module src.sections.CustomSection;

import src.sections.Section;
import src.sections.SectionId;

@SectionId(0)
class CustomSection : Section
{
    import src.utils : Utils;
    
    string name;
    ubyte[] data;

    this(uint start, const ubyte[] wasm)
    {
        super(start, wasm, "custom");
        this.parse(wasm);
    }

    void parse(const ubyte[] wasm)
    {
        auto nameData = Utils.readName(wasm[this.dataStart .. $]);
        this.name = nameData[0];
        this.end = this.dataStart + cast(uint)this.dataSize;
        this.data ~= wasm[(this.dataStart + nameData[1]) .. this.end];
    }
}