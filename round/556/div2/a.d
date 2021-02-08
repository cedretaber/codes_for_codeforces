import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nmr = readln.split.to!(int[]);
    auto R = nmr[2];
    auto ss = readln.split.to!(int[]);
    auto bs = readln.split.to!(int[]);

    sort!"a < b"(ss);
    sort!"a > b"(bs);

    if (ss[0] >= bs[0]) {
        writeln(R);
        return;
    }

    writeln(R - ss[0] * (R / ss[0]) + bs[0] * (R / ss[0]));
}