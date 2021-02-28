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

alias C = Tuple!(int, "i", long, "k", long, "c");

void main()
{
    int T; get(T);
    while (T--) {
        int N, M; get(N, M);
        int[] KS; get(KS);
        long[] CS; get(CS);
        C[] cs;
        foreach (i, c; CS) cs ~= C(i.to!int, 0, c);
        foreach (k; KS) ++cs[k - 1].k;
        sort!"a.c > b.c"(cs);
        auto bs = new bool[](M);
        long r;
        int i;
        foreach (c; cs) {
            while (c.k > 0 && i < c.i) {
                if (!bs[i]) {
                    bs[i] = true;
                    r += CS[i];
                    --c.k;
                }
                ++i;
            }
            bs[c.i] = true;
            while (c.k > 0) {
                r += c.c;
                --c.k;
            }
        }
        writeln(r);
    }
}
