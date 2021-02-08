import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto nm = readln.split.to!(int[]);
        auto N = nm[0];
        auto M = nm[1];
        if (N > M) swap(N, M);
        writeln(N == 1 || (N == 2 && M == 2) ? "YES" : "NO");
    }
}