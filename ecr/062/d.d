import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;

    long r;
    foreach (i; 2..N) {
        r += i * (i+1);
    }
    writeln(r);
}