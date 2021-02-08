import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void solve()
{
    auto N = readln.chomp.to!long;
    long x;
    foreach (long i; 0..32) {
        x += x + (2L^^i)^^2;
        if (N >= x) {
            N -= x;
        } else {
            writeln(i);
            return;
        }
    }
}

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        solve();
    }
}