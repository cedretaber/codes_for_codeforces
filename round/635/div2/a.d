import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto n = readln.split.to!(int[]);
        writeln(n[1], " ", n[2], " ", n[2]);
    }
}