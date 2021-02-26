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
        char[] ii; get(ii);
        auto ps = new int[](N + 1);
        auto max_s = new int[](N + 1);
        auto min_s = new int[](N + 1);
        int max_p, min_p, p;
        foreach (i; 0..N) {
            p += (ii[i] == '+' ? 1 : -1);
            ps[i+1] = p;
            max_p = max(max_p, p);
            min_p = min(min_p, p);
            max_s[i+1] = max_p;
            min_s[i+1] = min_p;
        }
        auto max_r = new int[](N + 1);
        auto min_r = new int[](N + 1);
        p = max_p = min_p = 0;
        foreach_reverse (i; 0..N) {
            p += (ii[i] == '+' ? -1 : 1);
            max_p = max(max_p, p);
            min_p = min(min_p, p);
            max_r[i+1] = max_p - p;
            min_r[i+1] = min_p - p;
        }
        
        while (M--) {
            int l, r; get(l, r);
            p = ps[l-1];
            max_p = max_s[l-1];
            min_p = min_s[l-1];
            if (r != N) {
                max_p = max(max_p, max_r[r+1] + p);
                min_p = min(min_p, min_r[r+1] + p);
            }
            writeln(max_p - min_p + 1);
        }
    }
}
