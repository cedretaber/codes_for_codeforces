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
    int A, B, K; get(A, B, K);
    if (K == 0) {
        char[] res;
        foreach (_; 0..B) res ~= '1';
        foreach (_; 0..A) res ~= '0';
        writeln("Yes");
        writeln(res);
        writeln(res);
        return;
    }

    if (A + B - 2 < K || A < 1 || B < 2) return writeln("No");
    auto a = A - 1, b = B - 2;
    char[] x;
    x ~= '0';
    foreach (_; 1..K) {
        if (a) {
            x ~= '0';
            --a;
        } else {
            x ~= '1';
            --b;
        }
    }
    x ~= '1';
    while (a) {
        x ~= '0';
        --a;
    }
    while (b) {
        x ~= '1';
        --b;
    }
    x ~= '1';
    reverse(x);

    a = A - 1; b = B - 2;
    char[] y;
    y ~= '1';
    foreach (_; 1..K) {
        if (a) {
            y ~= '0';
            --a;
        } else {
            y ~= '1';
            --b;
        }
    }
    y ~= '0';
    while (a) {
        y ~= '0';
        --a;
    }
    while (b) {
        y ~= '1';
        --b;
    }
    y ~= '1';
    reverse(y);
    writeln("Yes");
    writeln(x);
    writeln(y);
}
