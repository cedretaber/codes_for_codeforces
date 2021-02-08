import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
            args[0] = readln.split.to!Arg;
        } else static if (isTuple!Arg) {
            auto input = readln.split;
            static foreach (i; 0..Fields!Arg.length) {
                args[0][i] = input[i].to!(Fields!Arg[i]);
            }
        } else {
            args[0] = readln.chomp.to!Arg;
        }
    } else {
        auto input = readln.split;
        assert(input.length == Args.length);

        static foreach (i; 0..Args.length) {
            args[i] = input[i].to!(Args[i]);
        }
    }
}

void get_lines(Args...)(size_t N, ref Args args)
{
    import std.traits, std.range;

    static foreach (i; 0..Args.length) {
        static assert(isArray!(Args[i]));
        args[i].length = N;
    }

    foreach (i; 0..N) {
        static if (Args.length == 1) {
            get(args[0][i]);
        } else {
            auto input = readln.split;
            static foreach (j; 0..Args.length) {
                args[j][i] = input[j].to!(ElementType!(Args[j]));
            }
        }
    }
}

void solve()
{
    int N, Q; get(N, Q);
    long[] AS; get(AS);
    int p;
    foreach (i, a; AS) if (a == N) {
        p = i.to!int;
        break;
    }
    long sum_a = N;
    if (N == 1) {
        foreach (_; 0..Q+1) writeln(N);
        return;
    }

    long min_a, max_a;
    void update(long a) {
        if (min_a == -1) {
            if (a < max_a) {
                sum_a += max_a;
                max_a = -1;
                min_a = a;
            } else {
                max_a = a;
            }
        } else {
            if (a > min_a) {
                sum_a -= min_a;
                min_a = -1;
                max_a = a;
            } else {
                min_a = a;
            }
        }
    }
    if (p < N-1) {
        max_a = -1; min_a = AS[p+1];
        foreach (i; p+2..N) update(AS[i]);
        if (max_a != -1) sum_a += max_a;
    }
    if (p > 0) {
        max_a = -1; min_a = AS[p-1];
        foreach_reverse (i; 0..p-1) update(AS[i]);
        if (max_a != -1) sum_a += max_a;
    }
    writeln(sum_a);

    void swap_pos(int p, int q) {
        auto a = AS[p];
        auto b = AS[q];
        if (q == 0) {
            if (a < AS[q+1]) {
                // 2 3 ...
                if (b < AS[q+1]) return;
                sum_a = sum_a + b - AS[q+1];
            } else {
                // 2 3 ...
                if (b > AS[q+1]) {
                    sum_a = sum_a - a + b;
                } else {
                    sum_a = sum_a - a + AS[q+1];
                }
            }
            return;
        } else if (q == N-1) {
            if (AS[q-1] < a) {
                // ... 2 3
                if (AS[q-1] < b) {
                    sum_a = sum_a - a + b;
                } else {
                    sum_a = - a + AS[q-1];
                }
            } else {
                // ... 3 2
                if (AS[q-1] > b) return;
                sum_a = sum_a - AS[q-1] + b;
            }
            return;
        }

        if ((AS[q-1] < a) == (AS[q-1] < b) && (AS[q+1] < a) == (AS[q+1] < b)) return;

        if (AS[q-1] < a && a < AS[q+1]) {
            // 2 4 6
            if (AS[q-1] < b && b > AS[q+1]) {
                sum_a = sum_a + b - AS[q+1];
            }
            if (AS[q-1] > b && b < AS[q+1]) {
                sum_a = sum_a + AS[q-1] - b;
            }
        } else if (AS[q-1] > a && a > AS[q+1]) {
            // 6 4 2
            if (AS[q-1] < b && b > AS[q+1]) {
                sum_a = sum_a + b - AS[q-1];
            }
            if (AS[q-1] > b && b < AS[q+1]) {
                sum_a = sum_a + AS[q+1] - b;
            }
        } else if (AS[q-1] < a && a > AS[q+1]) {
            // 2 6 4
            if ((AS[q-1] < b && b < AS[q+1]) ||(AS[q-1] > b && b > AS[q+1])) {
                sum_a = sum_a + min(AS[q+1], AS[q-1]) - a;
            }
            if (AS[q-1] > b && b < AS[q+1]) {
                sum_a = sum_a + AS[q-1] - a - b + AS[q+1];
            }
        } else {
            // 4 2 6
            if ((AS[q-1] < b && b < AS[q+1]) ||(AS[q-1] > b && b > AS[q+1])) {
                sum_a = sum_a + min(AS[q+1], AS[q-1]) - a;
            }
            if (AS[q-1] < b && b > AS[q+1]) {
                sum_a = sum_a - AS[q-1] + a + b - AS[q+1];
            }
        }
    }

    while (Q--) {
        int L, R; get(L, R); --L; --R;
        if (L != R) {
            swap_pos(L, R);
            swap_pos(R, L);
            swap(AS[L], AS[R]);
        }
        writeln(sum_a);
    }
}

void main()
{
    int T; get(T);
    foreach (_; 0..T) solve();
}


/*
. . + . - . +
1 2 5 4 3 6 7


9 6 7 5 4 8

7 0
1 2 5 4 3 6 7

1 1
2 2
3 5
4 4
5 3
6 6
7 7


1 2 3 4 5 -> 5
5 4 3 2 1 -> 5


9 1 8 2 7 10 3 6 4 5


1 2 5 4 3 6 7
1 2
6 7
3 4
1 2
2 3

. . + . - . +
1 2 5 4 3 6 7 -> 9

+ - + . - . +
2 1 5 4 3 6 7 -> 10

+ - + . - + .
2 1 5 4 3 7 6 -> 10

+ - . + - + .
2 1 4 5 3 7 6 -> 10

. . . + - + .
1 2 4 5 3 7 6 -> 9

. + - + - + .
1 4 2 5 3 7 6 -> 11

隣り合う場合、
片方が . の時 -> 意味無し
両方が . の時 -> +/- に変わる
+/- の時 -> 両方が . に変わる

. . + . - . +
1 2 5 4 3 6 7 -> 9

3 7
1 2 7 4 3 6 5

2>7, 4>7 なので、i3は変化なし
6>5 なので、+6-5

2 6
1 6 5 4 3 2 7
1>6, 5>6 なので、 -5+6
2<3, 2<7 なので、 +3-2

!! 変更後の両脇の数字との関係性で全てが決まる

. .        + -
1 2 ... -> 2 1

+ -        . .
2 1 ... -> 1 2

3 4 6 -> 3 5 6
3 < 4 < 6 と 3 < 5 < 6 との関係性が一緒なので変化なし。

3 4 6 -> 3 7 6

- . +    - +
3 4 6 -> 3 7 6

. . +    . + .
3 4 6 -> 3 7 6

. . .    . + -
3 4 6 -> 3 7 6

+ . -    . + -
6 4 3 -> 6 7 3

=> 真ん中が一番大きくなった場合、両側の大きい方を引き、真ん中を足す

- . +    . - +
3 4 6 -> 3 2 6

. . +    + - +
3 4 6 -> 3 2 6

=> 真ん中が一番小さくなった場合、両側の小さい方を足し、真ん中を引く

+ - +    . + .
3 1 5 -> 3 7 5

+ - .    . + -
3 1 5 -> 3 7 5


- + -    . - .
3 7 5 -> 3 1 5

- + .    . - +
3 7 5 -> 3 1 5


- + - + .
3 7 5 6 1

. - . + .
3 1 5 6 7


*/