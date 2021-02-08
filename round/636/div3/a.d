import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto N = readln.chomp.to!long;
        long x = 1;
        foreach (k; 1..34) {
            x += 1L<<k;
            if (N%x == 0) {
                writeln(N/x);
                break;
            }
        }
    }
}