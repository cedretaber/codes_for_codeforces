import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

struct BITree(alias _fun, alias E, T)
if (is(typeof(E) : T))
{
    import std.functional : binaryFun;
    alias OP = binaryFun!_fun;

    ///
    this(size_t n, T[] ts) {
        this.n = n;
        this.tree.length = n+1;
        foreach (ref e; this.tree) e = E;
        foreach (i, t; ts) this.update(i, t);
    }

    void update(size_t i, T e) {
        i += 1;
        while (i <= this.n) {
            this.tree[i] = OP(this.tree[i], e);
            i += i & -i;
        }
    }

    ///
    T query(size_t i) {
        auto r = E;
        while (i > 0) {
            r = OP(r, this.tree[i]);
            i -= i & -i;
        }
        return r;
    }

private:
    size_t n;
    T[] tree;
}

auto bitree(alias fun, alias init, T)(size_t n, T[] ts = [])
{
    return BITree!(fun, init, T)(n, ts);
}

///
auto bitree(alias fun, alias init, T)(T[] ts)
{
    return BITree!(fun, init, T)(ts.length, ts);
}

auto sum_bitree(T)(size_t n, T[] ts = [])
{
    return bitree!("a + b", 0, T)(n, ts);
}

auto sum_bitree(T)(T[] ts)
{
    return sum_bitree!T(ts.length, ts);
}

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    auto bit = sum_bitree!int(N+1);
    foreach (_; 0..N) {
        int a;
        readf(" %d", &a);
        bit.update(a, 1);
    }
    foreach (_; 0..Q) {
        int q;
        readf(" %d", &q);
        if (q < 0) {
            q = -q;
            size_t l = 1, r = N+1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (bit.query(m) < q) {
                    l = m;
                } else {
                    r = m;
                }
            }
            bit.update(l, -1);
        } else {
            bit.update(q, 1);
        }
    }
    foreach (i; 1..N+1) if (bit.query(i+1) > 0) {
        writeln(i);
        return;
    }
    writeln(0);
}