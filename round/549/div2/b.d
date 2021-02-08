import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!(char[]);
    if (N.length == 1) {
        writeln(N);
        return;
    }
    long ret, r;
    foreach (i, d; N) {
        if (!i) {
            long s = d-49;
            if (!s) s = 1;
            s *= (9L^^(N.length-1));
            ret = s;
            r = d-48;
        } else if (i == N.length-1) {
            ret = max(ret, r * (d-48));
        } else {
            long s = d-49;
            if (!s) {
                r *= d-48;
                continue;
            }
            s = r * s * 9L^^(N.length-i-1);
            ret = max(ret, s);
            r *= d-48;
        }
    }
    writeln(ret);
}