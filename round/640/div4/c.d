import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        auto nk = readln.split.to!(long[]);
        auto N = nk[0];
        auto K = nk[1];

        if (K < N) {
            writeln(K);
            continue;
        }

        long l = 1, r = K*2+1;
        while (l+1 < r) {
            auto m = (l+r)/2;
            auto e = m/N;
            if (m-e >= K) {
                r = m;
            } else {
                l = m;
            }
        }
        writeln(r);
    }
}