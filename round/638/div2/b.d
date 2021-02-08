import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        auto nk = readln.split.to!(int[]);
        auto N = nk[0];
        auto K = nk[1];
        auto as = readln.split.to!(int[]);
        auto ns = new bool[](100);
        foreach (a; as) ns[a-1] = true;
        int c;
        foreach (n; ns) if (n) ++c;
        if (c > K) {
            writeln("-1");
            continue;
        }
        int[] ii;
        foreach (i, n; ns) if (n) ii ~= i.to!int+1;
        while (ii.length < K) ii ~= ii[0];
        int[] ms;
        size_t i;
        foreach (a; as) {
            while (a != ii[i]) {
                ms ~= ii[i++];
                i %= ii.length;
            }
            ms ~= a;
            ++i;
            i %= ii.length;
        }
        writeln(ms.length);
        writeln(ms.to!(string[]).join(" "));
    }
}