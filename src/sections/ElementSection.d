module src.sections.ElementSection;

import src.sections.Section;
import src.sections.SectionId;

@SectionId(9)
class ElementSection : Section
{
    this(uint start, const ubyte[] wasm)
    {
        super(start, wasm, "element");
    }
}