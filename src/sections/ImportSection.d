module src.sections.ImportSection;

import src.sections.Section;
import src.sections.SectionId;

@SectionId(2)
class ImportSection : Section
{
    this(uint start, const ubyte[] wasm)
    {
        super(start, wasm, "import");
    }
}