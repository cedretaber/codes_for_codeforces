import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto n = readln.chomp.to!int;
    auto s = readln.chomp;

    int r = int.max;
    foreach (i; 0..n-3) {
        int t;
        t += min(abs(s[i] - 39), abs(s[i] - 65), abs(s[i] - 91));
        t += min(abs(s[i+1] - 42), abs(s[i+1] - 67), abs(s[i+1] - 93));
        t += min(abs(s[i+2] - 58), abs(s[i+2] - 84), abs(s[i+2] - 110));
        t += min(abs(s[i+3] - 45), abs(s[i+3] - 71), abs(s[i+3] - 97));
        r = min(r, t);
    }
    writeln(r);
}