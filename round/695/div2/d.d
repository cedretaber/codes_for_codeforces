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
    int N, K, Q; get(N, K, Q);

    auto DP = new long[][](N, K + 1);
    foreach (i; 0..N) DP[i][0] = 1;
    foreach (k; 0..K) {
        (DP[1][k+1] += DP[0][k]) %= P;
        (DP[$-2][k+1] += DP[$-1][k]) %= P;
        foreach (i; 1..N-1) {
            (DP[i-1][k+1] += DP[i][k]) %= P;
            (DP[i+1][k+1] += DP[i][k]) %= P;
        }
    }
    auto CS = new long[](N);
    foreach (i; 0..N) foreach (k; 0..K + 1) (CS[i] += DP[i][k] * DP[i][K - k] % P) %= P;

    long[] aa; get(aa);

    long s;
    foreach (i; 0..N) (s += aa[i] * CS[i] % P) %= P;

    while (Q--) {
        int i; long x; get(i, x); --i;
        (s += P - aa[i] * CS[i] % P + x * CS[i] % P) %= P;
        aa[i] = x;
        writeln(s);
    }
}
