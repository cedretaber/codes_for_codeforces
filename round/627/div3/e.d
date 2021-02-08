import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nhlr = readln.split.to!(int[]);
    auto N = nhlr[0];
    auto H = nhlr[1];
    auto L = nhlr[2];
    auto R = nhlr[3];
    auto as = readln.split.to!(int[]);

    auto DP = new int[][](N, H);
    foreach (ref dp; DP) dp[] = -1;
    int solve(int i, int h) {
        if (i == N) return 0;
        if (DP[i][h] == -1) {
            auto r1 = (h + as[i]) % H;
            auto r2 = (h + as[i] - 1) % H;
            DP[i][h] = max(
                solve(i+1, r1) + (L <= r1 && r1 <= R ? 1 : 0),
                solve(i+1, r2) + (L <= r2 && r2 <= R ? 1 : 0)
            );
        }
        return DP[i][h];
    }
    writeln(solve(0, 0));
}