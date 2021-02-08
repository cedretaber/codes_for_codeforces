import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    auto ds = readln.split.to!(int[]);
    int l, r;
    foreach (d; ds) {
        if (d) {
            ++r;
        } else {
            ++l;
        }
    }
    int cnt;
    foreach (d; ds) {
        ++cnt;
        if (d) {
            --r;
        } else {
            --l;
        }
        if (!r || !l) {
            writeln(cnt);
            return;
        }
    }
}