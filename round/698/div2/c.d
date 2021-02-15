import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
          static if (isSomeChar!(ElementType!Arg)) {
            args[0] = readln.chomp.to!Arg;
          } else {
            args[0] = readln.split.to!Arg;
          }
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

void main()
{
    int T; get(T);
    while (T--) {
        int N; get(N);
        long[] D; get(D);
        sort(D);
        long[] dd;
        long a;
        for (int i; i < N * 2; i += 2) {
            if (D[i] != D[i+1] || D[i] % 2 != 0) goto ng;
            if (!dd.empty && dd[$-1] == D[i]) goto ng;
            dd ~= D[i];
        }
        if (dd[$-1] % (2 * N) != 0) goto ng;
        a = dd[$-1] / N / 2;
        foreach_reverse (i; 1..N) {
            auto d = dd[i] - dd[i-1];
            if (d % (i*2) != 0) goto ng;
            a -= d / (i*2);
            if (a <= 0) goto ng;
        }
        writeln("YES");
        continue;
        ng:
        writeln("NO");
    }
}

/*

2
8 12 8 12

8 12


a_1 * 2 + abs(a_1 - a_2) + abs(a_1 - a_3) + ... abs(a_1 - a_n) + a_1 + a_2 + a_1 + a_3 + ... a_1 + a_n = d_1
a_2 * 2 + abs(a_2 - a_1) + abs(a_2 - a_3) + ... abs(a_2 - a_n) + a_2 + a_1 + a_2 + a_3 + ... a_2 + a_n = d_2
a_3 * 2 + abs(a_3 - a_1) + abs(a_3 - a_2) + ... abs(a_3 - a_n) + a_3 + a_1 + a_3 + a_2 + ... a_3 + a_n = d_3


a を昇順に並べて、
d_i = ∑0..N|a_i - a_j| + ∑0..N(a_i + a_j) <=> ∑0..i(a_i - a_j) + ∑i..N(a_j - a_i) + ∑(a_i + a_j)


d_1 = (a_1 - a_1) + a_2 - a_1 + a_3 - a_1 + ... + a_n - a_1 + a_1 + a_1 + a_1 + a_2 + a_1 + a_3 + ... + a_1 + a_n
+a_1 * N+1, -a_1 * (N-1) => a_1 * 2
+a_2 .. a_n * 2

d_2 = a_2 - a_1 + (a_2 - a_2) + a_3 - a_2 + ... + a_n - a_2 + a_2 + a_1 + a_2 + a_2 + a_2 + a_3 + ... + a_2 + a_n
+a_2 * N+2, -a_2 * (N-2) => a_2 * 4
+a_3 ... a_n * 2

d_3 = a_3 - a_1 + a_3 - a_2 + (a_3 - a_3) + ... + a_n - a_3 + a_3 + a_1 + a_3 + a_2 + a_3 + a_3 + ... + a_3 + a_m
+a_3 * N+3, -a_3 => (N-3) => a_3 * 6
a_4 ... a_n * 2

d_2 - d_1 = a_2 * 2 - a_1 * 2
d_3 - d_2 = a_3 * 4 - a_2 * 4

2, 4, 6, 8

:

d_n = a_n - a_1 + a_n - a_2 + ... a_n - a_n + a_n + a_1 + a_n + a_2 + ... a_n + a_n
    = a_n * 2N

162 - 154 = 8
a_2 * 2 - a_1 * 2 = 8, a_2 - a_1 = 4
a_1 = 1 => a_2 = 3

174 - 162 = 12
a_3 * 4 - a_2 * 4 = 12, a_3 - a_2 = 3
a_2 = 3 => a_3 = 6

186 - 174 = 12
12 / 6 = 2
a_4 = 2 + 6 = 8

210 - 186 = 24
24 / 8 = 3
a_5 = 3 + 8 = 11

240 - 210 = 30
30 / 10 = 3
a_6 = 3 + 11 = 14

20 = 3 + a_5 => a_5 = 17
17 = 3 + a_4 => a_4 = 14
14 = 2 + a_3 => a_3 = 12
12 = 3 + a_2 => a_2 = 9
9 = 4 + a_1 => a_1 = 5



240 154 210 162 174 154 186 240 174 186 162 210

154 162 174 186 210 240



40 56 48 40 80 56 80 48
40 48 56 80

a = 10
80 - 56 = 24, 24 / 6 = 4
10 - 4 = 6
56 - 48 = 8, 8 / 4 = 2
6 - 2 = 4
48 - 40 = 8, 8 / 2 = 4
4 - 4 = 0

0 4 6 10
40
40 + 2 * 4




0 1 2
0 => 1 + 2 + 0 + 1 + 2 => 6
1 => 1 + 1 + 1 + 2 + 3 => 8
2 => 2 + 1 + 2 + 3 + 4 => 12

6 8 12

a = 2
12 - 8 = 4, 4 / 4 = 1
a = 1
8 - 6 = 2, 2 / 2 = 1
a = 0




*/