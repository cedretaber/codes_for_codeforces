import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    auto ab = readln.split.to!(long[]);
    auto A = ab[0];
    auto B = ab[1];

    auto mod = N*K;

    long max_d = 0, min_d = long.max;
    auto s1 = A;
    auto s2 = mod - A;
    foreach (n; 0..N) {
        auto b = n*K - B;
        if (b != s1) {
            auto l = abs(b - s1);
            auto d = mod * l / gcd(mod, l);
            max_d = max(max_d, d);
            min_d = min(min_d, d);
        }
        if (b != s2) {
            auto l = abs(b - s2);
            auto d = mod * l / gcd(mod, l);
            max_d = max(max_d, d);
            min_d = min(min_d, d);
        }

        auto c = n*K + B;
        if (c != s1) {
            auto l = abs(c - s1);
            auto d = mod * l / gcd(mod, l);
            max_d = max(max_d, d);
            min_d = min(min_d, d);
        }
        if (c != s2) {
            auto l = abs(c - s2);
            auto d = mod * l / gcd(mod, l);
            max_d = max(max_d, d);
            min_d = min(min_d, d);
        }
    }

    writefln("%d %d", min_d, max_d);
}