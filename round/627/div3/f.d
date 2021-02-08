import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto CS = readln.split.to!(int[]);
    int[][] T;
    T.length = N;
    foreach (_; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        T[a] ~= b;
        T[b] ~= a;
    }

    auto MD = new int[](N);
    int paint(int i, int p) {
        auto d = CS[i] ? 1 : -1;
        foreach (j; T[i]) if (j != p) d += max(0, paint(j, i));
        MD[i] = d;
        return d;
    }
    paint(0, -1);
    void solve(int i, int p) {
        if (p >= 0) {
            if (CS[i]) {
                MD[i] = max(MD[i], MD[p]);
            } else if (MD[i] <= 0) {
                MD[i] = max(MD[i], MD[p] + MD[i]);
            } else {
                MD[i] = max(MD[i], MD[p]);
            }
        }
        foreach (j; T[i]) if (j != p) solve(j, i);
    }
    solve(0, -1);

    writeln(MD.to!(string[]).join(" "));
}