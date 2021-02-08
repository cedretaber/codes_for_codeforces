import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum MAX_C = 200;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto N = readln.chomp.to!int;
        auto as = readln.split.to!(int[]);

        if (N == 1) {
            writeln(1);
            continue;
        } else if (N == 2) {
            writeln(as[0] == as[1] ? 2 : 1);
            continue;
        }

        auto cs = new int[][](N, MAX_C);
        foreach (i, ref a; as) {
            a -= 1;
            if (i) foreach (j; 0..MAX_C) cs[i][j] = cs[i-1][j];
            ++cs[i][a];
        }
        long res;
        foreach (i; 0..MAX_C) res = max(res, cs[N-1][i]);
        foreach (n; 0..MAX_C) {
            foreach (c; 1..cs[N-1][n]/2+1) {
                int i, j, l, r;

                if (cs[0][n] == c) {
                    i = 0;
                } else {
                    r = N-1;
                    while (l+1 < r) {
                        auto m = (l+r)/2;
                        if (cs[m][n] < c) {
                            l = m;
                        } else {
                            r = m;
                        }
                    }
                    i = r;
                }

                l = 0; r = N-1;
                while (l+1 < r) {
                    auto m = (l+r)/2;
                    if (cs[N-1][n] - cs[m][n] < c) {
                        r = m;
                    } else {
                        l = m;
                    }
                }
                j = l;

                int max_d;
                foreach (d; 0..MAX_C) max_d = max(max_d, cs[j][d] - cs[i][d]);

                res = max(res, c*2 + max_d);
            }
        }
        writeln(res);
    }
}