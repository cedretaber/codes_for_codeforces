import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto N = readln.chomp.to!long;
        long[][] as = [[]];
        size_t i;
        long last = 0;
        foreach (a; readln.split.to!(long[])) {
            if (last*a < 0) {
                sort!"a > b"(as[i]);
                ++i;
                as ~= [[]];
            }
            as[i] ~= a;
            last = a;
        }
        sort!"a > b"(as[i]);
        long s;
        foreach (a; as) s += a[0];
        writeln(s);
    }
}