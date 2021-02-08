import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void solve()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    auto X = nx[1];
    int sum_a, infected;
    bool all_same = true;
    foreach (a; readln.split.to!(int[])) {
        if (a != X) all_same = false;
        if (a == X) ++infected;
        sum_a += a;
    }
    if (all_same) {
        writeln(0);
    } else if (X*N == sum_a) {
        writeln(1);
    } else if (infected == 0) {
        writeln(2);
    } else {
        writeln(1);
    }
}

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        solve();
    }
}