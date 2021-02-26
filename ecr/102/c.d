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
        int N, K; get(N, K);
        auto res = 1.iota(K + 1).array();
        if (N != K) {
            auto i = K - (N - K) - 1;
            reverse(res[i..$]);
        }
        writefln!"%(%d %)"(res);
    }
}


/*

3 

1 1
1

2 2
1 2

3 2
1 2 1

4 3
1 2 3 2

1 3 2 3

1 2 3 4 5 6 7 8 9 8 7 6 5 4

1 2 3 4 5 6 7 9 8 9 7 6 5 4

1 2 3 5 4 6 7 8 9 8 7 6 4 5

1 2 3 9 8 7 6 5 4 5 6 7 8 9

1 2 3 2 1 => 1 + 3 = 4
3 2 1 2 3 => 2 + 2 = 4

1 2 3 4 3 2 1 => 1 + 3 + 5 = 9
4 3 2 1 2 3 4 => 2 + 4 + 3 = 9


1 2 3 4 5 4 3

1 2 5 4 3 4 5

*/
