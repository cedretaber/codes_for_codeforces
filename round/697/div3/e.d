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

enum P = 10L^^9 + 7;

void main()
{
    int T; get(T);
    while (T--) {
        int N, K; get(N, K);
        int[] aa; get(aa);
        auto MAX = new int[](K + 1);
        auto DP = new long[](K + 1);
        DP[0] = 1;
        foreach (a; aa) {
            foreach_reverse (i; 0..K) {
                if (MAX[i] + a > MAX[i+1]) {
                    MAX[i+1] = MAX[i] + a;
                    DP[i+1] = DP[i];
                } else if (MAX[i] + a == MAX[i+1]) {
                    (DP[i+1] += DP[i]) %= P;
                }
            }
        }
        writeln(DP[K]);
    }
}

/*

4 3
1 3 1 2

0 0 0 0
1 0 0 0

0 1 1 1
1 1 1 1

0 3 4 4
1 1 1 1

0 3 4 5
1 1 2 1

0 3 5 6
1 1 1 2

4 2
1 1 1 1

0 0 0
1 0 0

0 1 1
1 1 0

0 1 2
1 2 1

0 1 2
1 3 3

0 1 2
1 4 6

*/