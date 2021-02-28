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

enum PCNT = 10^^3;

bool[PCNT+1] PS;

void prime_init()
{
    PS[] = true;
    PS[0] = false;
    PS[1] = false;
    foreach (i; 2..PCNT+1) {
        if (PS[i]) {
            auto x = i*2;
            while (x <= PCNT) {
                PS[x] = false;
                x += i;
            }
        }
    }
}

void main()
{
    prime_init();
    long[] ps;
    foreach (i; 0..PCNT + 1) if (PS[i]) ps ~= i;

    int T; get(T);
    while (T--) {
        int N; get(N);
        long[] AS; get(AS);

        foreach (ref a; AS) foreach (p; ps) while (a % p^^2 == 0) a /= p^^2;
        sort(AS);
        AS ~= -1;
        long last = -1, cnt, one_and_evens, max_r;
        foreach (i, a; AS) {
            if (a != last) {
                max_r = max(max_r, cnt);
                if (last == 1 || cnt % 2 == 0) one_and_evens += cnt;
                cnt = 1;
                last = a;
            } else {
                ++cnt;
            }
        }
        auto r0 = max_r;
        auto r1 = max(max_r, one_and_evens);

        int Q; get(Q);
        while (Q--) {
            long W; get(W);
            writeln(W == 0 ? r0 : r1);
        }
    }
}



/*

10 = 2*5

6 8 4 2
=> 6 2^2 * 2 2^2 * 1 2
=> 6 

6 2 1 2
=> 6 4 1 4 => 6 1 1 1

12 3 20 5 80 1
=> 3 3 5 5 5 1
9 9 125 125 125 1 => 1 1 5 5 5 1
1 1 5 5 5 1


3 * 4 => 12
3 * 9 => 27

*/
