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
        int N, M; get(N, M);
        int[] aa, bb, cc; get(aa); get(bb); get(cc);
        auto ww = new int[][N + 1];
        auto rr = new int[](N + 1);
        rr[] = -1;
        foreach (i; 0..N) {
            auto a = aa[i], b = bb[i];
            if (a == b) {
                rr[a] = i.to!int;
            } else {
                ww[b] ~= i.to!int;
            }
        }

        auto res = new int[](M);
        int[] rest;
        foreach (i, c; cc) {
            if (ww[c].empty) {
                if (rr[c] == -1) {
                    rest ~= i.to!int;
                } else {
                    while (!rest.empty) {
                        res[rest.front] = rr[c];
                        rest.popFront();
                    }
                    res[i] = rr[c];
                }
            } else {
                while (!rest.empty) {
                    res[rest.front] = ww[c].front;
                    rest.popFront();
                }
                res[i] = ww[c].front;
                rr[c] = ww[c].front;
                ww[c].popFront();
            }
        }
        if (!rest.empty) goto ng;
        foreach (w; ww) if (!w.empty) goto ng;
        writefln!"YES\n%(%d %)"(res.map!"a + 1");
        continue;
        ng:
        writeln("NO");
    }
}