import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto xnm = readln.split.to!(int[]);
        auto X = xnm[0];
        auto N = xnm[1];
        auto M = xnm[2];

        while (N > 0 && X/2 >= 10) {
            X = X/2 + 10;
            --N;
        }
        writeln(X <= M*10 ? "YES" : "NO");
    }
}