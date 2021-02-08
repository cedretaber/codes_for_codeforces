import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto N = readln.chomp.to!int;
        auto as = readln.split.to!(int[]);
        sort(as);
        int[] bs;
        int i = (as.length.to!int-1)/2, j = (as.length.to!int-1)/2+1;
        for (;;) {
            if (i < 0) break;
            bs ~= as[i];
            if (j >= N) break;
            bs ~= as[j];
            --i;
            ++j;
        }
        writeln(bs.to!(string[]).join(" "));
    }
}