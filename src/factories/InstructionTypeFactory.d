module src.factories.InstructionTypeFactory;

class InstructionTypeFactory
{
    import src.instructions.Instruction;
    import src.instructions.InstructionList;

    static Instruction getInstructionById(uint start, const ubyte[] wasm)
    {
        switch (wasm[start])
        {
            case 0x20:
                return new LocalGet(start, wasm);
            case 0x6a:
                return new I32Add(start, wasm);
            default:
                return new ErrorInstruction(start, wasm);
        }
    }
}