import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias XW = Tuple!(long, "x", long, "w");

void main()
{
    auto N = readln.chomp.to!int;
    XW[] xws;
    foreach (_; 0..N) {
        auto xw = readln.split.to!(long[]);
        xws ~= XW(xw[0], xw[1]);
    }
    sort!"a.x + a.w < b.x + b.w"(xws);
    int r;
    long last = long.min;
    foreach (xw; xws) {
        if (last <= xw.x - xw.w) {
            ++r;
            last = xw.x + xw.w;
        }
    }
    writeln(r);
}