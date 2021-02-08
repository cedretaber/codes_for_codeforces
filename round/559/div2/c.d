import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto BS = readln.split.to!(long[]);
    auto GS = readln.split.to!(long[]);

    long ret;
    foreach (b; BS) {
        ret += b * M;
    }
    sort!"a > b"(BS);
    int c;
    sort!"a < b"(GS);
    foreach (g; GS) {
        if (g < BS[0]) {
            writeln("-1");
            return;
        }
        if (g == BS[0]) {
            continue;
        }
        if (c == M-1) {
            ret += g - BS[1];
        } else {
            ++c;
            ret += g - BS[0];
        }
    }
    writeln(ret);
}