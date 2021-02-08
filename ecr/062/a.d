import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^4+1] MEMO;

void main()
{
    auto N = readln.chomp.to!int;
    int n, r;
    foreach (i, a; readln.split.to!(int[])) {
        ++n;
        ++MEMO[a-1];
        n -= MEMO[i];
        if (!n) ++r;
    }
    writeln(r);
}