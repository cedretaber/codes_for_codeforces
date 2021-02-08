import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

alias Path = Tuple!(int, "to", bool, "c");

Path[][10^^5] GP;

void main()
{
    auto N = readln.chomp.to!int;
    int root;
    foreach (int i; 0..N) {
        auto pc = readln.split.to!(int[]);
        if (pc[0] == -1) {
            root = i;
        } else {
            GP[pc[0]-1] ~= Path(i, pc[1] == 1);
        }
    }

    auto ss = [Path(root, false)];
    int[] rs;
    while (!ss.empty) {
        auto head = ss[0];
        ss = ss[1..$];
        if (head.c) {
            bool del = true;
            foreach (path; GP[head.to]) {
                if (!path.c) del = false;
                ss ~= path;
            }
            if (del) rs ~= head.to + 1;
        } else {
            ss ~= GP[head.to];
        }
    }
    sort(rs);
    writeln(rs.empty ? "-1" : rs.to!(string[]).join(" "));
}