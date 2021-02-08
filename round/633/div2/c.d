import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    long[63] ns, cs;
    foreach (i; 0..63) ns[i] = (1L<<(i+1))-1;
    foreach (_; 0..T) {
        auto N = readln.chomp.to!int;
        auto as = readln.split.to!(long[]);
        cs[] = 0;
        foreach (i; 0..N-1) {
            if (as[i+1] >= as[i]) continue;
            foreach (j, n; ns) if (as[i] - as[i+1] <= n) {
                ++cs[j];
                as[i+1] = as[i];
                break;
            }
        }
        foreach_reverse (i, c; cs) if (c > 0) {
            writeln(i+1);
            goto ok;
        }
        writeln(0);
        ok:
    }
}