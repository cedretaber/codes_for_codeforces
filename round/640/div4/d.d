import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        auto N = readln.chomp.to!int;
        auto as = readln.split.to!(long[]);
        long a, sa, b, sb;
        int c;
        while (!as.empty) {
            ++c;
            long d;
            if (c%2 == 1) {
                do {
                    d += as[0];
                    as = as[1..$];
                } while (!as.empty && d <= b);
                a = d;
                sa += d;
            } else {
                do {
                    d += as[$-1];
                    as = as[0..$-1];
                } while (!as.empty && d <= a);
                b = d;
                sb += d;
            }
        }
        writeln(c, " ", sa, " ", sb);
    }
}