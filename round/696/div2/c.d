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
        int[] AA; get(AA);
        sort(AA);
        foreach (i; 0..N*2-1) {
            int[][int] memo;
            foreach_reverse (j, a; AA[0..$-1]) if (i != j) memo[a] ~= j.to!int;
            auto aa = new int[](N);
            aa[0] = AA[$-1];
            auto bb = new int[](N);
            bb[0] = AA[i];
            auto j = N*2 - 1;
            if (i == j) --j;
            auto fs = new bool[](N * 2);
            fs[$-1] = fs[i] = true;
            foreach (k; 1..N) {
                auto x = aa[k-1];
                while (fs[j]) --j;
                auto a = AA[j];
                memo[a].popFront();
                fs[j] = true;
                --j;
                auto b = x - a;
                if (b !in memo || memo[b].empty) goto ng;
                fs[memo[b].front] = true;
                memo[b].popFront();
                aa[k] = a;
                bb[k] = b;
            }
            writeln("YES\n", aa[0] + bb[0]);
            foreach (k; 0..N) writeln(aa[k], " ", bb[k]);
            goto ok;
            ng:
        }
        writeln("NO");
        continue;
        ok:
    }
}

/*

2
3 5 1 2
=>1 2 3 5

8 -> 3-5
7 -> 2-5
6 -> 1-5
-> 5

5 -> 3-2
4 -> 3-1
-> 3

3 -> 1-2
-> 2


1 2 3 4 5 6 7 14 3 11
1 2 3 3 4 5 6 7 11 14

14 - ?
-> 14
11 - 3
-> 11
7 - 4
-> 7
6 - 1
-> 6
5 ... x

*/