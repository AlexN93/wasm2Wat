module src.sections.StartSection;

import src.sections.Section;
import src.sections.SectionId;

@SectionId(8)
class StartSection : Section
{
    this(uint start, const ubyte[] wasm)
    {
        super(start, wasm, "start");
    }
}