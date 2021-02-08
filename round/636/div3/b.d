import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto N = readln.chomp.to!int;
        if ((N/2)%2 == 1) {
            writeln("NO");
            continue;
        }
        int[] as, bs;
        int x;
        foreach (_i; 0..N/2) {
            ++x;
            if (x%2 == 1) {
                bs ~= x++;
                as ~= x++;
            } else {
                as ~= x++;
                bs ~= x++;
            }
        }
        writeln("YES");
        writeln((as ~= bs).to!(string[]).join(" "));
    }
}