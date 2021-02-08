import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long mod(long n, long m)
{
    auto r = n % m;
    if (r < 0) {
        return m + r;
    }
    return r;
}

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto N = readln.chomp.to!long;
        auto as = readln.split.to!(long[]);
        auto memo = new bool[](N.to!size_t);
        foreach (i, a; as) {
            auto r = mod(a + i.to!long, N).to!int;
            if (memo[r]) goto ng;
            memo[r] = true;
        }
        writeln("YES");
        continue;
        ng:
        writeln("NO");
    }
}