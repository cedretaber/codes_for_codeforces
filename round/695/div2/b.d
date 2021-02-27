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
        int N; get(N);
        int[] AS; get(AS);
        AS = [AS[0]] ~ AS ~ AS[$-1];
        int c, x;
        foreach (i; 2..N) {
            auto a = AS[i];
            if (AS[i] > AS[i-1] && AS[i] > AS[i+1]) ++c;
            if (AS[i] < AS[i-1] && AS[i] < AS[i+1]) ++c;
            int check() {
                int n;
                if (AS[i] > AS[i-1] && AS[i] > AS[i+1]) ++n;
                if (AS[i] < AS[i-1] && AS[i] < AS[i+1]) ++n;
                if (AS[i-1] > AS[i-2] && AS[i-1] > AS[i]) ++n;
                if (AS[i-1] < AS[i-2] && AS[i-1] < AS[i]) ++n;
                if (AS[i+1] > AS[i+2] && AS[i+1] > AS[i]) ++n;
                if (AS[i+1] < AS[i+2] && AS[i+1] < AS[i]) ++n;
                return n;
            }
            auto n = check();
            int d;
            AS[i] = AS[i-1];
            d = max(d, n - check());
            AS[i] = AS[i+1];
            d = max(d, n - check());
            x = max(d, x);
            AS[i] = a;
        }
        writeln(c - x);
    }
}

/*

6 2 5 3 1
6 2 2 3 1

*/
