import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto MAP = new char[][](N.to!size_t, M.to!size_t);
    foreach (i; 0..N) foreach (j, c; readln.chomp) MAP[i][j] = c;

    bool rb, cb;
    foreach (i; 0..N) {
        bool rrb = true;
        foreach (j; 0..M) if (MAP[i][j] == '#') {
            rrb = false;
            break;
        }
        if (rrb) {
            rb = true;
            break;
        }
    }
    foreach (j; 0..M) {
        bool ccb = true;
        foreach (i; 0..N) if (MAP[i][j] == '#') {
            ccb = false;
            break;
        }
        if (ccb) {
            cb = true;
            break;
        }
    }
    if (rb != cb) {
        writeln(-1);
        return;
    }

    foreach (i; 0..N) {
        bool cd;
        if (MAP[i][0] == '#') cd = true;
        foreach (j; 1..M) {
            if (MAP[i][j-1] == '.' && MAP[i][j] == '#') {
                if (cd) {
                    writeln(-1);
                    return;
                } else {
                    cd = true;
                }
            }
        }
    }
    foreach (j; 0..M) {
        bool cd;
        if (MAP[0][j] == '#') cd = true;
        foreach (i; 1..N) {
            if (MAP[i-1][j] == '.' && MAP[i][j] == '#') {
                if (cd) {
                    writeln(-1);
                    return;
                } else {
                    cd = true;
                }
            }
        }
    }
    auto cs = new int[][](N.to!size_t, M.to!size_t);
    int c;
    foreach (i; 0..N) foreach (j; 0..M) if (MAP[i][j] == '#' && cs[i][j] == 0) {
        void paint(int i, int j) {
            foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
                auto ii = i+d[0];
                auto jj = j+d[1];
                if (ii < 0 || ii >= N || jj < 0 || jj >= M || MAP[ii][jj] == '.' || cs[ii][jj] != 0) continue;
                cs[ii][jj] = c;
                paint(ii, jj);
            }
        }
        ++c;
        cs[i][j] = c;
        paint(i, j);
    }
    writeln(c);
}