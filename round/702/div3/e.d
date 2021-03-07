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

alias P = Tuple!(int, "i", long, "t");

void main()
{
    int T; get(T); while (T--) {
        int N; get(N);
        long[] AA; get(AA);
        P[] ps;
        foreach (i, a; AA) ps ~= P(i.to!int + 1, a);
        sort!"a.t < b.t"(ps);
        int[] rs;
        long s;
        foreach (i; 0..N-1) {
            auto p = ps[i];
            s += p.t;
            if (ps[i + 1].t <= s) {
                rs ~= p.i;
            } else {
                rs = [];
            }
        }
        rs ~= ps[$-1].i;
        sort(rs);
        writeln(rs.length);
        writefln!"%(%d %)"(rs);
    }
}
