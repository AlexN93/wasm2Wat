module src.instructions.InstructionList;

import src.instructions.Instruction;
import src.instructions.LocalInstruction;

class LocalGet : LocalInstruction
{
    this(uint start, const ubyte[] wasm)
    {
        super(start, wasm);
    }
}

class I32Add : Instruction
{
    this(uint start, const ubyte[] wasm)
    {
        super(start, wasm);
    }
}

class ErrorInstruction : Instruction
{
    import std.stdio;

    this(uint start, const ubyte[] wasm)
    {
        throw new Exception("TODO - Add proper error message");
    }
    
}