import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        auto N = readln.chomp.to!int;
        auto as = readln.split.to!(int[]);
        if (N == 1) {
            writeln(0);
            continue;
        }
        int r;
        foreach (a; as) {
            int s = as[0] + as[1];
            size_t i, j = 2;
            while (i < N-1) {
                if (s == a) {
                    goto ok;
                } else if (s < a && j < N) {
                    s += as[j++];
                } else if (i < j-2) {
                    s -= as[i++];
                } else if (j < N) {
                    s += as[j++];
                } else {
                    break;
                }
            }
            continue;
            ok:
            ++r;
        }
        writeln(r);
    }
}