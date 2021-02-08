import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;
import std.container.rbtree;

alias S = Tuple!(long, "t", long, "b");

S[10^^5*3] SS;

long[10^^5*3] MIN_P;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    foreach (i; 0..N) {
        auto tb = readln.split.to!(long[]);
        SS[i] = S(tb[0], tb[1]);
    }

    sort!"a.b > b.b"(SS[0..N]);

    long t, p, r;
    auto tree = redBlackTree!true(0L);
    foreach (i; 0..N) {
        if (!tree.front) tree.removeFront();
        t += SS[i].t;
        tree.insert(SS[i].t);
        if (tree.length > K) {
            t -= tree.front;
            tree.removeFront();
        }
        r = max(r, t * SS[i].b);
    }

    writeln(r);
}