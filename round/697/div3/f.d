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
        char[][] A, B;
        get_lines(N, A);
        readln;
        get_lines(N, B);

        auto M = new bool[][](N, N);
        foreach (i; 0..N) foreach (j; 0..N) if (A[i][j] != B[i][j]) M[i][j] = true;
        foreach (i; 1..N) if (M[i-1][0] != M[i][0]) foreach (j; 0..N) M[i][j] = !M[i][j];
        foreach (j; 0..N) foreach (i; 0..N) if (M[i][j] != M[0][j]) goto ng;
        writeln("YES");
        continue;
        ng:
        writeln("NO");
    }
}

/*

110
001
110

000
000
000

**.
..*
**.

101
010
101

010
101
010

***
***
***

01
11

10
10

**
.*

*/