import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto nk = readln.split.to!(int[]);
        auto N = nk[0];
        auto K = nk[1];
        auto as = readln.split.to!(int[]);

        auto ns = new int[]((K*2+2).to!size_t);
        foreach (i; 0..N/2) {
            auto x = as[i.to!size_t];
            auto y = as[(N-i-1).to!size_t];
            if (x > y) swap(x, y);
            auto p = x+y;
            ns[0] += 2;
            ns[(x+1).to!size_t] -= 1;
            ns[p.to!size_t] -= 1;
            ns[(p+1).to!size_t] += 1;
            ns[(y+K+1).to!size_t] += 1;
        }
        foreach (i; 0..ns.length-1) {
            ns[i+1] += ns[i];
        }

        int min_n = int.max;
        foreach (i; 0..ns.length) {
            min_n = min(min_n, ns[i]);
        }
        writeln(min_n);
    }
}