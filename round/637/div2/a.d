import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        auto nn = readln.split.to!(int[]);
        auto N = nn[0];
        auto A = nn[1];
        auto B = nn[2];
        auto C = nn[3];
        auto D = nn[4];
        if ((A-B)*N > (C+D) || (A+B)*N < (C-D)) {
            writeln("No");
        } else {
            writeln("Yes");
        }
    }
}