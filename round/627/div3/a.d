import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        readln;
        auto as = readln.split.to!(int[]);
        auto x = as[0]%2;
        foreach (a; as) if (x != a%2) goto ng;
        writeln("YES");
        continue;
        ng:
        writeln("NO");
    }
}