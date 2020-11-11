module src.sections.TableSection;

import src.sections.Section;
import src.sections.SectionId;

@SectionId(4)
class TableSection : Section
{
    this(uint start, const ubyte[] wasm)
    {
        super(start, wasm, "table");
    }
}