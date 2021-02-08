import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto ds = readln.split.to!(int[]);
    sort(ds);
    auto gr = readln.split.to!(int[]);
    auto G = gr[0];
    auto R = gr[1];

    auto DP = new long[][](M, G);
    foreach (ref dp; DP) dp[] = long.max/3;

    long solve(int i, int g) {
        if (i == M-1) return 0;

        int r;
        if (g == G) {
            g = 0;
            r = R;
        }

        if (DP[i][g] == -1) {
            return long.max/3+1;
        }

        if (DP[i][g] == long.max/3) {
            DP[i][g] = -1;
            long res = long.max/3;
            if (i != 0 && g + ds[i] - ds[i-1] <= G) res = min(res, solve(i-1, g + ds[i] - ds[i-1]) + ds[i] - ds[i-1] + r);
            if (g + ds[i+1] - ds[i] <= G) res = min(res, solve(i+1, g + ds[i+1] - ds[i]) + ds[i+1] - ds[i] + r);
            if (res > long.max/3) res = long.max/3+1;
            DP[i][g] = res;
        }
        return DP[i][g];
    }

    auto r = solve(0, 0);
    if (r >= long.max/3) {
        writeln(-1);
    } else {
        writeln(r);
    }
}