import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto nab = readln.split.to!(int[]);
        auto N = nab[0];
        auto A = nab[1];
        auto B = nab[2];

        char[] rs, ss;
        foreach (i; 0..A) {
            rs ~= (min(i, B-1) + 'a').to!char;
        }
        foreach (i; 0..N) {
            ss ~= rs[i%A];
        }
        writeln(ss);
    }
}