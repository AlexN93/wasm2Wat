module src.sections.MemorySection;

import src.sections.Section;
import src.sections.SectionId;

@SectionId(5)
class MemorySection : Section
{
    this(uint start, const ubyte[] wasm)
    {
        super(start, wasm, "memory");
    }
}