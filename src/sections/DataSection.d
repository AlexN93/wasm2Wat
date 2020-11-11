module src.sections.DataSection;

import src.sections.Section;
import src.sections.SectionId;

@SectionId(11)
class DataSection : Section
{
    this(uint start, const ubyte[] wasm)
    {
        super(start, wasm, "data");
    }
}