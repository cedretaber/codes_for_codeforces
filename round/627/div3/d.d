import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);
    auto bs = readln.split.to!(long[]);
    long[] cs;
    foreach (i; 0..N) cs ~= as[i] - bs[i];
    sort(cs);
    long res;
    foreach (i; 0..N-1) {
        auto c = cs[i];
        if (cs[$-1] + c <= 0) continue;
        if (cs[i+1] + c > 0) {
            res += N-i-1;
            continue;
        }
        int l = i+1, r = N-1;
        while (l+1 < r) {
            auto m = (l+r)/2;
            if (cs[m] + c > 0) {
                r = m;
            } else {
                l = m;
            }
        }
        res += N - r;
    }
    writeln(res);
}