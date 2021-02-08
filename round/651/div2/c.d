import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        auto N = readln.chomp.to!long;
        if (N == 1) {
            writeln("FastestFinger");
            continue;
        }
        if (N == 2 || N%2 == 1) {
            writeln("Ashishgup");
            continue;
        }
        auto n = N;
        int t;
        while (n%2 == 0) {
            ++t;
            n /= 2;
        }
        if (n == 1) {
            writeln("FastestFinger");
            continue;
        }
        if (t > 1) {
            writeln("Ashishgup");
            continue;
        }

        int c;
        for (long k = 3; k^^2 <= N; k += 2) {
            while (n%k == 0) {
                ++c;
                n /= k;
            }
        }
        if (n != 1) {
            ++c;
        }
        writeln(c == 1 ? "FastestFinger": "Ashishgup");
    }
}