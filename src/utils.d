module src.utils;

class Utils
{
    import std.bitmanip;
    import std.typecons;
    
    static Tuple!(ulong, uint) readULEB128(const(ubyte)[] buffer)
    {
        ulong val = 0;
        uint shift = 0;

        while (true)
        {
            const ubyte b = buffer.read!ubyte();

            val |= (b & 0x7f) << shift;
            if ((b & 0x80) == 0) break;
            shift += 7;
        }

        return tuple(val, (shift+7)/7);
    }

    static Tuple!(string, uint) readName(const(ubyte)[] buffer)
    {
        auto ulebParsed = readULEB128(buffer);
        ulong length = ulebParsed[0];
        uint offcet = ulebParsed[1];
        uint consumed = offcet + cast(uint)length;
        return tuple(cast(string)buffer[offcet .. consumed], consumed);
    }
}