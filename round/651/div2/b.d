import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        auto N = readln.chomp.to!int;
        auto aa = readln.split.to!(int[]);
        int[] os, es;
        foreach (i, a; aa) {
            if (a%2 == 0) {
                es ~= i.to!int+1;
            } else {
                os ~= i.to!int+1;
            }
        }
        int cnt;
        while (cnt < N-1 && os.length > 1) {
            writeln(os[0], " ", os[1]);
            ++cnt;
            os = os[2..$];
        }
        while (cnt < N-1) {
            writeln(es[0], " ", es[1]);
            ++cnt;
            es = es[2..$];
        }
    }
}