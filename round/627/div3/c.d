import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto S = readln.chomp;
        int max_l, l;
        foreach (c; S) {
            if (c == 'L') {
                l += 1;
                max_l = max(l, max_l);
            } else {
                l = 0;
            }
        }
        writeln(max_l + 1);
    }
}