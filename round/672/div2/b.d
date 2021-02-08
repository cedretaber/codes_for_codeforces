import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
            args[0] = readln.split.to!Arg;
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

uint bits_msb(uint v)
{
    v = v | (v >>  1);
    v = v | (v >>  2);
    v = v | (v >>  4);
    v = v | (v >>  8);
    v = v | (v >> 16);
    return v ^ (v >> 1);
}

void solve()
{
    int N; get(N);
    uint[] AS; get(AS);
    long[33] cs;
    foreach (a; AS) {
        a = bits_msb(a);
        static foreach (i; 0..33) {
            if (a & 1) ++cs[i];
            a >>= 1;
        }
    }
    long r;
    foreach (c; cs) r += c * (c-1) / 2;
    writeln(r);
}

void main()
{
    int T; get(T);
    foreach (_; 0..T) solve();
}

/*

00001 1
00100 4
00011 3
00111 7
01010 10

00110 6
00010 2
00101 5
00011 3

*/