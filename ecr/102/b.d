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
        char[] s, t; get(s); get(t);
        char[] r;
        if (s.length > t.length) swap(s, t);
        foreach (l; 1..s.length + 1) if (s.length % l == 0 && t.length % l == 0) {
            auto x = s[0..l];
            auto n = (s.length / l) * (t.length / l) / gcd(s.length / l, t.length / l);
            foreach (i; 0..s.length / l) if (s[i * l..i * l + l] != x) goto next;
            foreach (i; 0..t.length / l) if (t[i * l..i * l + l] != x) goto next;
            if (r.empty || r.length > l * n) {
                r = [];
                foreach (_; 0..n) r ~= x;
            }
            next:
        }
        if (r.empty) {
            writeln(-1);
        } else {
            writeln(r);
        }
    }
}
