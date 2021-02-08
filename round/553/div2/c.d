import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

enum P = 10L^^9+7;

long[10^^5+50] F, RF;

void init()
{
    F[0] = F[1] = 1;
    foreach (i, ref x; F[2..$]) x = (F[i+1] * (i+2)) % P;

    {
        RF[$-1] = 1;
        auto x = F[$-1];
        auto k = P-2;
        while (k) {
            if (k%2 == 1) RF[$-1] = (RF[$-1] * x) % P;
            x = x^^2 % P;
            k /= 2;
        }
    }
    foreach_reverse(i, ref x; RF[0..$-1]) x = (RF[i+1] * (i+1)) % P;
}

long solve(long n)
{
    long odd, even, x = 1, s = 1;
    foreach (i; 0..70) {
        if (i%2 == 0) odd += x;
        else even += x;
        x *= 2;
        s += x;
        if (s >= n) break;
    }
    if (odd > even) {
        even += n-(odd+even);
    } else {
        odd += n-(odd+even);
    }
    auto y = (min(odd, even)%P * 2)%P;
    auto r = ((y * (y+1))%P * RF[2])%P;
    auto t = (n%P-y+P)%P;
    m = (y+2)%P;
    r = (r + (t*m)%P)%P;
    r = (r + ((t-1+P)%P*t)%P)%P;
    writeln([odd, even]);
    writeln(t);
    writeln(m);
    return r;
}

void main()
{
    init();
    auto lr = readln.split.to!(long[]);
    auto l = lr[0];
    auto r = lr[1];

    auto ret = solve(r);
    if (l-1) {
        ret -= solve(l-1);
        if (ret < 0) ret += P;
    }
    writeln(ret);
}