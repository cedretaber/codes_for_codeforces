import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto N = readln.chomp.to!int;
        int[] rs;
        int k = 0;
        while (N) {
            if (N%10 != 0) {
                rs ~= N%10 * 10^^k;
            }
            N /= 10;
            ++k;
        }
        writeln(rs.length);
        writeln(rs.to!(string[]).join(" "));
    }
}