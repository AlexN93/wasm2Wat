module src.entities.Export;

class Export
{
    import src.entities.ExportDescriptor;
    import src.utils;

    uint start;
    uint end;
    string name;
    ExportDescriptor exportDescriptor;

    this(uint start, const ubyte[] wasm)
    {
        this.start = start;
        this.parse(wasm);
    }

    void parse(const ubyte[] wasm)
    {
        auto nameData = Utils.readName(wasm[this.start .. $]);
        this.name = nameData[0];
        this.exportDescriptor = new ExportDescriptor(this.start + nameData[1], wasm);
        this.end = this.exportDescriptor.end;
    }

    string toWatString()
    {
        return "\u0024" ~ this.name ~ " (export \u0022" ~ this.name ~ "\u0022)";
    }
}