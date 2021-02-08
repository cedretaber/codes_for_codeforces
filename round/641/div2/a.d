import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    auto ps = new long[](10^^6+1);
    foreach (i; 2..10^^6+1) if (ps[i] == 0) {
        ps[i] = i;
        auto x = i;
        while (x <= 10^^6) {
            if (ps[x] == 0) ps[x] = i;
            x += i;
        }
    }
    foreach (_t; 0..T) {
        auto nk = readln.split.to!(long[]);
        auto N = nk[0];
        auto K = nk[1];
        writeln(N + ps[N.to!size_t] + 2*(K-1));
    }
}