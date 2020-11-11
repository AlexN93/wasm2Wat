module src.instructions.LocalInstruction;

import src.instructions.Instruction;

static class LocalInstruction : Instruction
{
    import std.conv;
    import src.instructions.Index;

    Index localIndex;

    this() {}

    this(uint start, const ubyte[] wasm)
    {
        super(start, wasm);
        this.parse(wasm);
    }

    public void parse(const ubyte[] wasm)
    {
        this.localIndex = new Index(this.start + 1, wasm);
        this.end = this.localIndex.end;
    }

    override string toWatString()
    {
        return text(this.Instruction.instructionTypes[this.code], " $var", to!string(this.localIndex.value));
    }
}