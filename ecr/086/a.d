import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto xy = readln.split.to!(long[]);
        auto x = xy[0];
        auto y = xy[1];
        auto ab = readln.split.to!(long[]);
        auto a = ab[0];
        auto b = ab[1];

        writeln(min(
            x * a + y * a,
            min(x, y) * b + abs(x - y) * a
        ));
    }
}