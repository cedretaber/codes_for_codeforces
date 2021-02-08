import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long lcm(long a, long b)
{
    return a * b / gcd(a, b);
}

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);
    auto ls = new long[](N);
    ls[0] = as[0];
    foreach (i; 1..N) ls[i] = gcd(as[i], ls[i-1]);
    auto rs = new long[](N);
    rs[$-1] = as[$-1];
    foreach_reverse (i; 0..N-1) rs[i] = gcd(as[i], rs[i+1]);

    auto x = rs[1];
    foreach (i; 1..N-1) x = lcm(x, gcd(ls[i-1], rs[i+1]));
    writeln(lcm(x, ls[$-2]));
}