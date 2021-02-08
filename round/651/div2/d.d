import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias A = Tuple!(int, "i", int, "a");

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    int o_i, o_j, e_i, e_j;
    if (K%2 == 0) {
        o_i = 0;
        o_j = N-2;
        e_i = 1;
        e_j = N-1;
    } else {
        o_i = 0;
        o_j = N-1;
        e_i = 1;
        e_j = N-2;
    }

    int[] aa, bb;
    foreach (a; readln.split.to!(int[])) {
        aa ~= a;
        bb ~= a;
    }
    sort(bb);
    bb.uniq();
    int l = -1, r = N-1;
    while (l+1 < r) {
        auto m = (l+r)/2;
        auto a = bb[m];
        // odd
        {
            int i = o_i;
            int o;
            while (i <= o_j) {
                if (aa[i] <= a) {
                    ++o;
                    ++i;
                }
                ++i;
            }

            if (o >= (K+1)/2) {
                r = m;
                continue;
            }
        }
        // even
        {
            auto i = e_i;
            int e;
            while (i <= e_j) {
                if (aa[i] <= a) {
                    ++e;
                    ++i;
                }
                ++i;
            }

            if (e >= K/2) {
                r = m;
                continue;
            }
        }

        l = m;
    }
    writeln(bb[r]);
}