import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto t = readln.chomp;
        int o, z;
        foreach (c; t) {
            if (c == '0') ++z;
            if (c == '1') ++o;
        }
        if (o == 0 || z == 0) {
            writeln(t);
            continue;
        }

        char[] s;
        foreach (i; 0..t.length-1) {
            s ~= t[i];
            if (t[i] == t[i+1]) {
                if (t[i] == '0') {
                    s ~= '1';
                } else {
                    s ~= '0';
                }
            }
        }
        s ~= t[$-1];
        writeln(s);
    }
}