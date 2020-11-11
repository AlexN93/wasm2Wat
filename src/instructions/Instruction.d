module src.instructions.Instruction;

static class Instruction {
    uint start;
    uint end;
    ubyte code;
    static enum string[ubyte] instructionTypes = [0x20: "local.get", 0x6a: "i32.add"];
    
    this() {}

    this(uint start, const ubyte[] wasm)
    {
        this.start = start;
        this.end = this.start + 1;
        this.code = wasm[start];
    }

    string toWatString()
    {
        return this.instructionTypes[this.code];
    }
}