import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        auto nk = readln.split.to!(int[]);
        auto N = nk[0];
        auto K = nk[1];
        auto as = readln.split.to!(int[]);

        int p;
        foreach (i; 0..K) {
            if (i != K-1 && i > 0 && i < N-1 && as[i] > as[i-1] && as[i] > as[i+1]) ++p;
        }
        int max_p = p, min_l = 1;
        foreach (i; 1..N-K+1) {
            auto j = i+K-1;
            if (as[j-1] > as[j-2] && as[j-1] > as[j]) ++p;
            if (as[i] > as[i-1] && as[i] > as[i+1]) --p;
            if (p > max_p) {
                max_p = p;
                min_l = i+1;
            }
        }
        writeln(max_p+1, " ", min_l);
    }
}