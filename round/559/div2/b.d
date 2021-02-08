import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);

    auto k = int.max, x = int.max, n = N;
    size_t i, j = N-1;
    while (i <= j) {
        --n;
        x = min(x, AS[i]);
        x = min(x, AS[j]);
        k = min(k, x / n);
        ++i;
        --j;
    }
    writeln(k);
}