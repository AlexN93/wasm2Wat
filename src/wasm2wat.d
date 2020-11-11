module src.wasm2wat;

class Wasm2Wat
{
    import std.stdio;
    import src.sections.Section;
    import src.factories.SectionTypeFactory;

    const ubyte[] wasm;
    Section[string] sections;

    this(const ubyte[] wasm)
    {
        this.wasm = wasm;
    }

    public bool validateMagic()
    {
        // Need to check if 13 is really the minimum
        if (this.wasm.length < 13)
            return false;
        
        if (this.wasm[0 .. 4] != [0x00, 0x61, 0x73, 0x6d] || this.wasm[4 .. 8] != [0x01, 0x00, 0x00, 0x00])
            return false;
        
        return true;
    }

    public void populateSections()
    {
        uint offcet = 8;
        while (offcet < this.wasm.length) {
            auto section = SectionTypeFactory.getSectionById(offcet, wasm);
            this.sections[section.type] = section;
            offcet = section.dataStart + cast(uint)section.dataSize;
        }
    }

    public string getSectionsWat()
    {
        string result = "";
        if (!this.sections.length)
            return result;
        result ~= "(module";
        foreach (Section s; this.sections) {
            if (s.type == "type")
                s.toWatString(result);
            else if (s.type == "function") {
                s.toWatString(result, this.sections);
            }
        }
        return result ~ ")";
    }
}