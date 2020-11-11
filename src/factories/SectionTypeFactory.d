module src.factories.SectionTypeFactory;

import src.sections.Section : Section;
import src.sections.CustomSection : CustomSection;
import src.sections.TypeSection : TypeSection;
import src.sections.ImportSection : ImportSection;
import src.sections.FunctionSection : FunctionSection;
import src.sections.TableSection : TableSection;
import src.sections.MemorySection : MemorySection;
import src.sections.GlobalSection : GlobalSection;
import src.sections.ExportSection : ExportSection;
import src.sections.StartSection : StartSection;
import src.sections.ElementSection : ElementSection;
import src.sections.CodeSection : CodeSection;
import src.sections.DataSection : DataSection;

class SectionTypeFactory
{
    import std.meta;
    import std.traits;
    import src.sections.SectionId;

    alias SectionTypes = AliasSeq!(
        CustomSection,
        TypeSection,
        ImportSection,
        FunctionSection,
        TableSection,
        MemorySection,
        GlobalSection,
        ExportSection,
        StartSection,
        ElementSection,
        CodeSection,
        DataSection
    );

    static Section getSectionById(uint start, const ubyte[] wasm)
    {
        final switch (wasm[start])
            static foreach (type; SectionTypes)
                case getUDAs!(type, SectionId)[0].id:
                    return new type(start, wasm);
    }
}