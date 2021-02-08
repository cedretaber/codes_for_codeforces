import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto abq = readln.split.to!(int[]);
        long A = abq[0];
        long B = abq[1];
        if (A > B) swap(A, B);

        long solve(long n) {
            if (n < B) return n;

            auto lcm = A * B / gcd(A, B);
            long r = min(n, B-1) + (n / lcm - 1) * B;
            auto m = n / lcm * lcm;
            r += min(m + B, n+1) - m;
            return r;
        }

        auto Q = abq[2];
        long[] res;
        foreach (_q; 0..Q) {
            auto lr = readln.split.to!(long[]);
            auto l = lr[0];
            auto r = lr[1];
            res ~= r - l + 1 - solve(r) + solve(l-1);
        }
        writeln(res.to!(string[]).join(" "));
    }
}