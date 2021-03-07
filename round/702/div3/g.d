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
    int T; get(T); while (T--) {
        int N, M; get(N, M);
        long[] AA; get(AA);
        long[] XX; get(XX);

        auto ss = new long[](N);
        ss[0] = AA[0];
        foreach (i; 1..N) ss[i] += ss[i - 1] + AA[i];
        
        auto ms = new long[](N);
        ms[0] = ss[0];
        foreach (i; 1..N) ms[i] = max(ms[i-1], ss[i]);

        long[] res;
        foreach (x; XX) {
            if (ss[$-1] <= 0 && x > ms[$-1]) {
                res ~= -1;
                continue;
            }
            auto min_a = max(0, x - ms[$-1]);
            auto c = ss[$-1] <= 0 ? 0 : (min_a + ss[$-1] - 1) / ss[$-1];
            auto d = ss[$-1] * c;
            if (d + AA[0] >= x) {
                res ~= c * N;
                continue;
            }
            int l, r = (N-1).to!int;
            while (l + 1 < r) {
                auto m = (l + r) / 2;
                if (d + ms[m] >= x) {
                    r = m;
                } else {
                    l = m;
                }
            }
            res ~= c * N + r;
        }
        writefln!"%(%d %)"(res);
    }
}
