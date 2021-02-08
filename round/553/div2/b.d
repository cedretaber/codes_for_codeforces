import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int[500][500] IS;
int[10][500] BS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (i; 0..N) {
        int[10] ds;
        foreach (j, n; readln.split.to!(int[])) {
            IS[i][j] = n;
            foreach (d; 0..10) {
                auto x = (n>>d)&1;
                if (!j) {
                    ds[d] = x;
                } else if (ds[d] != x) {
                    ds[d] = 2;
                }
            }
        }
        BS[i] = ds;
    }
    int targ_d = -1, one_cnt;
    foreach (d; 0..10) {
        one_cnt = 0;
        foreach (i; 0..N) {
            if (BS[i][d] == 2) {
                targ_d = d;
            } else if (BS[i][d] == 1) {
                ++one_cnt;
            }
        }
        if (one_cnt%2 == 1) targ_d = d;
        if (targ_d != -1) break;
    }
    if (targ_d == -1) {
        writeln("NIE");
        return;
    }
    one_cnt = one_cnt%2 == 1 ? 0 : 1;
    int[] r;
    foreach (j, ns; IS[0..N]) {
        if (BS[j][targ_d] != 2) {
            r ~= 1;
        } else {
            foreach (int i, n; ns[0..M]) {
                auto x = (n>>targ_d)&1;
                if (one_cnt && x) {
                    --one_cnt;
                    r ~= i+1;
                    break;
                } else if (!one_cnt && !x) {
                    r ~= i+1;
                    break;
                }
            }
        }
    }
    writeln("TAK");
    writeln(r.to!(string[]).join(" "));
}