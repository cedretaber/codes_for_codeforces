import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        auto nk = readln.split.to!(int[]);
        auto N = nk[0];
        auto K = nk[1];

        auto SS = readln.chomp.to!(dchar[]);
        sort(SS);
        auto S = SS.to!(char[]);

        char[] a;
        if (N == 1) {
            a = S;
        } else if (S[0] != S[K-1]) {
            a = [S[K-1]];
        } else if (S[0] == S[$-1]) {
            foreach (_c; 0..(S.length.to!int+K-1)/K) a ~= S[0];
        } else if (S[K] == S[$-1]) {
            auto n = S.length.to!int-K;
            a ~= S[0];
            foreach (_c; 0..(n+K-1)/K) a ~= S[K];
        } else {
            a = [S[0]] ~ S[K..$];
        }
        writeln(a);
    }
}