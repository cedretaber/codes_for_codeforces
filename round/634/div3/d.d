import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

char change(char c) {
    c += 1;
    if (c > '9') c = '1';
    return c;
}

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        char[9][9] S;
        foreach (i; 0..9) foreach (j, c; readln.chomp) S[i][j] = c;
        S[0][0] = change(S[0][0]);
        S[1][3] = change(S[1][3]);
        S[2][6] = change(S[2][6]);
        S[3][1] = change(S[3][1]);
        S[4][4] = change(S[4][4]);
        S[5][7] = change(S[5][7]);
        S[6][2] = change(S[6][2]);
        S[7][5] = change(S[7][5]);
        S[8][8] = change(S[8][8]);
        foreach (s; S) writeln(s);
    }
}