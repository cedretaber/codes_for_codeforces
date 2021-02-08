import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        auto N = readln.chomp.to!int;
        if (N <= 3) {
            writeln(-1);
            continue;
        }

        auto rs = new int[](N);
        auto i = (N-1)/2;
        rs[i] = N;
        rs[i-1] = N-2;
        rs[i+1] = N-3;
        rs[i+2] = N-1;
        size_t l = i-2, r = i+3;
        auto n = N-4;
        for (;;) {
            if (n <= 0) break;
            rs[l--] = n--;
            if (n <= 0) break;
            rs[r++] = n--;
        }
        writeln(rs.to!(string[]).join(" "));
    }
}