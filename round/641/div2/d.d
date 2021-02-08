import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        auto nk = readln.split.to!(int[]);
        auto N = nk[0];
        auto K = nk[1];
        int[] as;
        bool has;
        foreach (a; readln.split.to!(int[])) {
            if (a == K) has = true;
            as ~= a;
        }
        if (!has) {
            writeln("no");
            continue;
        }
        if (N == 1) {
            writeln(has ? "yes" : "no");
            continue;
        }
        foreach (i, a; as[0..$-1]) if (a >= K) {
            if (as[i+1] >= K) goto ok;
            if (i+2 < N && as[i+2] >= K) goto ok;
        }
        writeln("no");
        continue;
        ok:
        writeln("yes");
    }
}