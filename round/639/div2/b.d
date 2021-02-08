import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    auto cs = new long[](25820);
    cs[1] = 2;
    foreach (i; 2..25820) {
        cs[i] = cs[i-1] + (i-1) * 3 + 2;
    }

    foreach (_; 0..T) {
        auto N = readln.chomp.to!int;

        int res;
        while (N >= 2) {
            ++res;
            if (N >= cs[$-1]) {
                N -= cs[$-1];
            } else {
                int l = 1, r = cs.length.to!int-1;
                while (l+1 < r) {
                    auto m = (l+r)/2;
                    if (N >= cs[m]) {
                        l = m;
                    } else {
                        r = m;
                    }
                }
                N -= cs[l];
            }
        }
        writeln(res);
    }
}