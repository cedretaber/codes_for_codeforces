import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto nk = readln.split.to!(long[]);
        auto N = nk[0];
        auto K = nk[1];

        auto d = N / K;
        auto r = N % K;
        auto x = d+r;

        if (d == 0) {
            writeln("NO");
            continue;
        }

        if (d%2 != x%2) {
            if (d <= 1 || K%2 == 0) {
                writeln("NO");
                continue;
            }
            d -= 1;
            x += K-1;
        }
        
        long[] as;
        foreach (_k; 0..K-1) as ~= d;
        as ~= x;
        writeln("YES");
        writeln(as.to!(string[]).join(" "));
    }
}