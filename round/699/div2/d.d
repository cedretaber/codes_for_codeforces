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
        char[][] G; get_lines(N, G);
        int[] res;
        
        if (M % 2 == 1) {
            foreach (i; 0..M+1) res ~= i % 2 + 1;
            goto ok;
        }

        if (N == 2 && (G == ["*a", "b*"] || G == ["*b", "a*"])) {
            writeln("NO");
            continue;
        }

        foreach (i; 0..N-1) foreach (j; i+1..N) if (G[i][j] == G[j][i]) {
            auto pp = [i+1, j+1];
            foreach (k; 0..M+1) res ~= pp[k%2];
            goto ok;
        }

        foreach (k; 0..N) {
            int i = -1, j = -1;
            foreach (l; 0..N) {
                if (G[k][l] == 'a') {
                    i = l;
                } else if (G[k][l] == 'b') {
                    j = l;
                }

                if (i != -1 && j != -1) {
                    if (M / 2 % 2 == 0) {
                        res ~= k + 1;
                        foreach (c; 0..M/2) res ~= (c % 2 == 0 ? i : k) + 1;
                    } else {
                        res ~= i + 1;
                        foreach (c; 0..M/2) res ~= (c % 2 == 0 ? k : i) + 1;
                    }
                    foreach (c; 0..M/2) res ~= (c % 2 == 0 ? j : k) + 1;
                    goto ok;
                }
            }
        }

        ok:
        writefln!"YES\n%(%d %)"(res);
        continue;
    }
}