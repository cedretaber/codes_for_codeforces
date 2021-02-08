import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto n = readln.chomp.to!double * 2;
        auto t = 180 * (n - 2) / 2 / n * PI / 180.0;
        writefln("%.12f", 0.5 * tan(t) * 2);
    }
}