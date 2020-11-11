module src.sections.GlobalSection;

import src.sections.Section;
import src.sections.SectionId;

@SectionId(6)
class GlobalSection : Section
{
    this(uint start, const ubyte[] wasm)
    {
        super(start, wasm, "global");
    }
}