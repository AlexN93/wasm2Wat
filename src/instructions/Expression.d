module src.instructions.Expression;

class Expression
{
    import std.conv;
    import src.factories.InstructionTypeFactory;
    import src.instructions.Instruction;

    uint start;
    uint end;
    ubyte endByte;
    Instruction[] instructions;

    this(uint start, uint end, const ubyte[] wasm)
    {
        this.start = start;
        this.parse(end, wasm);
    }

    void parse(uint end, const ubyte[] wasm)
    {
        uint offcet = this.start;
        while (true) {
            ubyte code = wasm[offcet];
            if (!end && offcet == (end-1)) 
                break;
            if (end && (code == 0x05 || code == 0x0b))
                break;
            Instruction i = InstructionTypeFactory.getInstructionById(offcet, wasm);
            this.instructions ~= i;
            offcet = i.end;
        }
        this.endByte = wasm[offcet];
        this.end = offcet + 1; // 0x05, 0x0b
    }

    string toWatString()
    {
        string result = "";
        if (!this.instructions.length) 
            return result;
        foreach (Instruction i; this.instructions) {
            result ~= text("    ", i.toWatString(), "\n");
        }
        return result;
    }
}