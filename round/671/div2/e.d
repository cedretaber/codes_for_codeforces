import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void solve()
{
    auto N = readln.chomp.to!long;
    long[] ps = [N];
    for (long i = 2; i^^2 <= N; ++i) {
        if (N%i == 0) {
            ps ~= i;
            if (i^^2 != N) ps ~= N/i;
        }
    }
    writeln(ps);
}

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        solve();
    }
}

/*

6 2 3

* *
*   *

2 2
  3 3

4 2

2 2
  2

3 5 2


3 3 3 3
  2 2     2 2
    5 5 5 5

* *   *   *
  * *     * *
    * * * *

12
2 6 3 4 12
2 3

* * *
    * * *

9

30, 2, 15, 3, 10, 5, 6


30 2 6 3 15 5 10

*/