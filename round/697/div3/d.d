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
        int N; long M; get(N, M);
        long[] aa; get(aa);
        int[] bb; get(bb);
        long[] hs, ls;
        foreach (i; 0..N) {
            if (bb[i] == 2) {
                hs ~= aa[i];
            } else {
                ls ~= aa[i];
            }
        }
        sort!"a > b"(hs);
        sort!"a > b"(ls);
        int res = int.max;

        if (ls.empty) {
            foreach (i, h; hs) {
                M -= h;
                if (M <= 0) res = min(res, (i.to!int + 1) * 2);
            }
        } else {
            auto cs = new long[](ls.length);
            foreach (i; 0..ls.length) {
                if (i) cs[i] = cs[i-1];
                cs[i] += ls[i];
                if (cs[i] >= M) res = min(res, i.to!int + 1);
            }
            long MM = M;
            foreach (i; 0..hs.length) {
                MM -= hs[i];
                int rr = (i + 1).to!int * 2;
                if (MM <= 0) {
                    res = min(res, rr);
                } else if (MM - cs[$-1] > 0) {
                    continue;
                } else {
                    int l = -1, r = cs.length.to!int;
                    while (l + 1 < r) {
                        auto m = (l + r) / 2;
                        if (MM - cs[m] <= 0) {
                            r = m;
                        } else {
                            l = m;
                        }
                    }
                    res = min(res, rr + r + 1);
                }
            }
        }

        writeln(res == int.max ? -1 : res);
    }
}