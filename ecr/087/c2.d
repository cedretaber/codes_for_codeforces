import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto n = readln.chomp.to!double * 2;
        if (n == 4) {
            writefln("%.12f", 1.0);
            continue;
        }
        auto r = 1.0 / sin(PI / n);

        auto d = 2.0 * PI / n;
        auto res = 0.0;
        foreach (x; 0..n.to!int) {
            auto t = 45.0 * PI / 180.0 + d * x;
            res = max(res, r * sin(t));
        }
        writefln("%.12f", res);
    }
}