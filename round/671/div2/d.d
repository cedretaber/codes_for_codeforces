import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    sort!"a > b"(AS);

    auto BS = new int[](N);
    int i, j;
    while (j < N) {
        BS[j] = AS[i];
        ++i;
        j += 2;
    }
    foreach (k; 0..N) if (BS[k] == 0) BS[k] = AS[i++];
    if (N%2 == 0) {
        int k = 1;
        while (k < N-1) {
            if (BS[k-1] > BS[k] && BS[k+1] > BS[k]) {
                k += 2;
                continue;
            }
            BS[$-1] = BS[k];
            BS[k] = AS[i-1];
            goto end;
        }
    }
    end:

    int r;
    foreach (k; 1..N-1) if (BS[k-1] > BS[k] && BS[k+1] > BS[k]) ++r;
    writeln(r);
    writeln(BS.to!(string[]).join(" "));
}

/*

7
1 3 2 2 4 5 4

5 4 4 3 2 2 1

5 _ 4 _ 4 _ 3
  2   2   1

8
3 2 3 2 2 2 2 1


4 3 4 3 5 2 3

5 3 4 3 4 2 3


5 4 5 4 5 4 5
*/