import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        auto N = readln.chomp.to!int;
        auto ss = readln.split.to!(int[]);
        auto DP = new int[](N+1);
        foreach_reverse (i; 1..N+1) {
            int x = i * 2, n = 1;
            while (x <= N) {
                if (ss[x-1] > ss[i-1]) n = max(n, DP[x] + 1);
                x += i;
            }
            DP[i] = n;
        }
        int r;
        foreach (ref e; DP) r = max(r, e);
        writeln(r);
    }
}