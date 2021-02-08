import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    long[] as, bs, cs = [0];
    foreach (i; 0..N) {
        auto ab = readln.split.to!(long[]);
        as ~= ab[0];
        bs ~= ab[1];
        cs ~= (cs[i] + as[i] + bs[i]) % K;
    }

    auto DP = new long[][](N+1, K+1);
    foreach (ref dp; DP) dp[] = long.min/3;
    DP[0][0] = 0;
    foreach (i; 0..N) {
        foreach (j; 0..cs[i]+1) {
            auto base = (as[i] + bs[i]) / K;
            auto rest = (as[i] + bs[i]) % K;
            auto k = cs[i] - j;
            foreach (jj; 0..rest+1) {
                auto kk = rest - jj;
                DP[i+1][jj] = max(DP[i+1][jj], DP[i][(j + jj) % K] + base + (j+jj)/K + (k+kk)/K);
            }
        }
    }
    long r;
    foreach (j; 0..K+1) r = max(r, DP[N][j]);
    writeln(r);
}