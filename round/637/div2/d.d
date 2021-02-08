import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

enum BS = [
    0b1110111,
    0b0010010,
    0b1011101,
    0b1011011,
    0b0111010,
    0b1101011,
    0b1101111,
    0b1010010,
    0b1111111,
    0b1111011
];

enum CS = [6, 2, 5, 5, 4, 5, 6, 3, 7, 6];

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    uint[] ss;
    int[] cs;
    foreach (_; 0..N) {
        uint s;
        foreach (i, c; readln.chomp) if (c == '1') s |= 1<<(6-i);
        ss ~= s;
        cs ~= popcnt(s);
    }

    auto DP = new bool[][](N, K+1);
    auto ANS = new int[](N);
    bool solve(int i, int k) {
        if (i == N) return k == 0;
        if (DP[i][k]) return false;

        auto s = ss[i];
        foreach_reverse (n, b; BS) {
            if ((s & b) == s && CS[n] - cs[i] <= k) {
                ANS[i] = n.to!int;
                if (solve(i+1, k - (CS[n] - cs[i]))) return true;
            }
        }
        DP[i][k] = true;
        return false;
    }

    if (solve(0, K)) {
        foreach (a; ANS) write(a);
        writeln();
    } else {
        writeln(-1);
    }
}