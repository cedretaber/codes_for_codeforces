import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        auto N = readln.chomp.to!long;
        long[] as;
        long b = 1;
        N -= 1;
        while (N) {
            if (N <= b*2) {
                as ~= N-b;
                break;
            }
            if (N <= b*4) {
                as ~= N/2-b;
                b = N/2;
            } else {
                as ~= b;
                b *= 2;
            }
            N -= b;
        }
        writeln(as.length);
        writeln(as.to!(string[]).join(" "));
    }
}

/*
   1
1: 0.5 0.5
   1.5 1.5
0: 1.5 1.5
   2.5 2.5
2: 1.25 1.25 1.25 1.25
   2.25 2.25 2.25 2.25
   -> 9

   1
1: 0.5 0.5
   1.5 1.5
1: 0.75 0.75 1.5
   1.75 1.75 2.5
0: 1.75 1.75 2.5
   2.75 2.75 3.5
   -> 9

   1
1: 0.5 0.5
   1.5 1.5 +2
1: 0.75 0.75 1.5
   1.75 1.75 2.5 +3
2: 0.875 0.875 0.875 0.875 2.5
   1.875 1.875 1.875 1.875 3.5 +5
   -> 11

   1
1: 0.5 0.5
   1.5 1.5
2: 0.75 0.75 0.75 0.75
   1.75 1.75 1.75 1.75
0: 1.75 1.75 1.75 1.75
   2.75 2.75 2.75 2.75
   -> 11

9-1 = 8
8-2 = 6
6-3 = 3
3-3 = 0


   1
0: 1
   2
1: 1 1
   2 2
2: 
*/