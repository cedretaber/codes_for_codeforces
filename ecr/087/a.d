import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto ad = readln.split.to!(long[]);
        auto A = ad[0];
        auto B = ad[1];
        auto C = ad[2];
        auto D = ad[3];

        if (A <= B) {
            writeln(B);
            continue;
        }

        auto e = C - D;
        if (e <= 0) {
            writeln(-1);
            continue;
        }

        A -= B;
        auto f = (A + e - 1) / e;
        writeln(B + C * f);
    }
}