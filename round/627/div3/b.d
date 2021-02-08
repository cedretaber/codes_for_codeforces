import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto N = readln.chomp.to!int;
        auto as = readln.split.to!(int[]);
        auto xs = new int[](5001);
        auto ls = new int[](5001);
        foreach (i; 1..N+1) {
            auto a = as[i-1];
            if (xs[a]) {
                if (xs[a] > 1) goto ok;
                if (ls[a] != i-1) goto ok;
            }
            ++xs[a];
            ls[a] = i;
        }
        writeln("NO");
        continue;
        ok:
        writeln("YES");
    }
}