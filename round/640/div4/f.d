import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        auto nn = readln.split.to!(int[]);
        auto n0 = nn[0];
        auto n1 = nn[1];
        auto n2 = nn[2];

        char[] rs;
        if (n1 == 0) {
            if (n0 > 0) {
                foreach (_n; 0..n0+1) rs ~= '0';
            } else {
                foreach (_n; 0..n2+1) rs ~= '1';
            }
            writeln(rs);
            continue;
        }

        if (n1%2 == 0) {
            rs ~= '1';
            --n1;
        }
        foreach (_n; 0..n0+1) rs ~= '0';
        foreach (_n; 0..n1/2) rs ~= "10";
        foreach (_n; 0..n2+1) rs ~= '1';

        writeln(rs);
    }
}