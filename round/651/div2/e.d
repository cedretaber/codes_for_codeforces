import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto T = readln.chomp;

    int s, t, c, max_c, d, max_d;
    foreach (i; 0..N) {
        auto s1 = S[i] == '1';
        auto t1 = T[i] == '1';
        if (s1) ++s;
        if (t1) ++t;

        if (s1 && !t1) {
            ++c;
            if (d > 0) --d;
        } else if (!s1 && t1) {
            ++d;
            if (c > 0) --c;
        }
        max_c = max(max_c, c);
        max_d = max(max_d, d);
    }

    if (s != t) {
        writeln(-1);
    } else {
        writeln(max(max_c, max_d));
    }
}