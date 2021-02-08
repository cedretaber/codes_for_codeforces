import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void solve()
{
    auto N = readln.chomp.to!int;
    auto ps = readln.split.to!(int[]);

    auto ii = new size_t[](N);
    foreach (i, ref p; ps) {
        p -= 1;
        ii[p] = i;
    }

    auto bs = new bool[](N);
    size_t i = ii[0];
    int n;
    for (;;)  {
        bs[i] = true;
        ++i;
        ++n;
        if (n == N) break;
        if (i == N || bs[i]) {
            i = ii[n];
            continue;
        }
        if (ps[i] != n) {
            writeln("No");
            return;
        }
    }
    writeln("Yes");
}

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        solve();
    }
}