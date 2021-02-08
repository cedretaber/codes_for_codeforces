import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    readln;
    auto os = readln.chomp;
    int n;
    foreach (o; os) {
        if (o == '+') {
            ++n;
        } else if (o == '-' && n > 0) {
            --n;
        }
    }
    writeln(n);
}