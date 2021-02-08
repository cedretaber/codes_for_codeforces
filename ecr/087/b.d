import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto S = readln.chomp;
        auto len = S.length;
        auto l1 = new size_t[](len);
        auto r1 = new size_t[](len);
        auto l2 = new size_t[](len);
        auto r2 = new size_t[](len);
        auto l3 = new size_t[](len);
        auto r3 = new size_t[](len);

        auto i1 = len, i2 = len, i3 = len;
        foreach (i, c; S) {
            switch (c) {
                case '1': i1 = i; break;
                case '2': i2 = i; break;
                default: i3 = i;
            }
            l1[i] = i1;
            l2[i] = i2;
            l3[i] = i3;
        }
        i1 = len, i2 = len, i3 = len;
        foreach_reverse (i, c; S) {
            switch (c) {
                case '1': i1 = i; break;
                case '2': i2 = i; break;
                default: i3 = i;
            }
            r1[i] = i1;
            r2[i] = i2;
            r3[i] = i3;
        }

        auto res = size_t.max;
        foreach (i; 0..len) {
            switch (S[i]) {
                case '1':
                    if (l2[i] != len && r3[i] != len) {
                        res = min(res, r3[i] - l2[i] + 1);
                    }
                    if (l3[i] != len && r2[i] != len) {
                        res = min(res, r2[i] - l3[i] + 1);
                    }
                    break;
                case '2':
                    if (l1[i] != len && r3[i] != len) {
                        res = min(res, r3[i] - l1[i] + 1);
                    }
                    if (l3[i] != len && r1[i] != len) {
                        res = min(res, r1[i] - l3[i] + 1);
                    }
                    break;
                default:
                    if (l2[i] != len && r1[i] != len) {
                        res = min(res, r1[i] - l2[i] + 1);
                    }
                    if (l1[i] != len && r2[i] != len) {
                        res = min(res, r2[i] - l1[i] + 1);
                    }
            }
        }
        writeln(res == size_t.max ? 0 : res);
    }
}