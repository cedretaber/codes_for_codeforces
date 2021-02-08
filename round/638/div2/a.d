import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        auto N = readln.chomp.to!long;
        long a = 2L^^N, b;
        foreach (i; 1..N/2) {
            a += 2L^^i;
        }
        foreach (i; N/2..N) {
            b += 2L^^i;
        }
        writeln(a - b);
    }
}