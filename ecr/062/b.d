import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void solve()
{
    auto n = readln.chomp.to!int;
    auto S = readln.chomp.to!(char[]);
    int r, s;
    foreach (c; S) {
        if (c == '<') r = 0;
        else ++r;
    }
    foreach_reverse (c; S) {
        if (c == '>') s = 0;
        else ++s;
    }
    writeln(min(r, s));
}

void main()
{
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) solve();
}