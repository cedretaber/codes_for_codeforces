import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto N = readln.chomp.to!int;
        auto ns = new int[](N);
        foreach (a; readln.split.to!(int[])) ++ns[a-1];
        int cnt, max_n;
        foreach (n; ns) if (n > 0) {
            ++cnt;
            max_n = max(max_n, n);
        }
        if (cnt < max_n) {
            writeln(cnt);
        } else if (max_n < cnt) {
            writeln(max_n);
        } else {
            writeln(cnt-1);
        }
    }
}