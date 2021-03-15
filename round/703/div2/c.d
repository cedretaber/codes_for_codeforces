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
    int N; get(N);
    writefln!"? %d %d"(1, N); stdout.flush();
    int p; get(p);
    int q;
    if (p == 1) {
        q = -1;
    } else if (p == N) {
        q = N;
    } else {
        writefln!"? %d %d"(1, p); stdout.flush();
        get(q);
    }
    if (p == q) {
        int l = 1, r = p;
        while (l + 1 < r) {
            auto m = (l + r) / 2;
            writefln!"? %d %d"(m, p); stdout.flush();
            get(q);
            if (p == q) {
                l = m;
            } else {
                r = m;
            }
        }
        writeln("! ", l); stdout.flush();
    } else {
        int l = p, r = N;
        while (l + 1 < r) {
            auto m = (l + r) / 2;
            writefln!"? %d %d"(p, m); stdout.flush();
            get(q);
            if (p == q) {
                r = m;
            } else {
                l = m;
            }
        }
        writeln("! ", r); stdout.flush();
    }
}

/*

******!******

**!***

もし同じ位置だった場合 -> そっち側に最大値がある
もし違う位置だった場合 -> 反対側に最大値がある

1 2 3 4 5
1 2 3 5 4
4 1 2 3 5


*/
