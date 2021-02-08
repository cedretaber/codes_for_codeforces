import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

///
struct PriorityQueue(alias _fun, T) {
    import std.functional : binaryFun;
    import std.algorithm : swap;
    alias fun = binaryFun!_fun;

    ///
    this(T[] ts) {
        foreach (t; ts) enqueue(t);
    }

    ///
    PriorityQueue!(_fun, T) enqueue(T e) {
        if (this.tree.length == 0) this.tree.length = 1;
        if (this.tree.length == this.n) this.tree.length *= 2;
        this.tree[this.n] = e;
        auto i = this.n;
        this.n += 1;
        while (i) {
            auto j = (i-1)/2;
            if (fun(this.tree[i], this.tree[j])) {
                swap(this.tree[i], this.tree[j]);
                i = j;
            } else break;
        }
        return this;
    }

    alias insertFront = enqueue;
    alias insert = enqueue;

    ///
    T dequeue() {
        auto ret = this.tree[0];
        this.n -= 1;
        this.tree[0] = this.tree[this.n];
        this.tree = this.tree[0..$-1];
        size_t i;
        for (;;) {
            auto l = i*2+1;
            auto r = i*2+2;
            if (l >= this.n) break;
            size_t j;
            if (r >= this.n) {
                j = l;
            } else {
                j = fun(this.tree[r], this.tree[l]) ? r : l;
            }
            if (fun(this.tree[j], this.tree[i])) {
                swap(this.tree[i], this.tree[j]);
                i = j;
            } else break;
        }
        return ret;
    }

    ///
    @property
    T front() {
        return this.tree[0];
    }

    ///
    @property
    bool empty() {
        return this.n == 0;
    }

    ///
    void popFront() {
        this.dequeue();
    }

    alias removeFront = popFront;

    ///
    @property
    size_t length() {
        return this.n;
    }

private:
    size_t n;
    T[] tree;
}

///
PriorityQueue!(fun, T) priority_queue(alias fun, T)(T[] ts = []) {
    return PriorityQueue!(fun, T)(ts);
}

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    int[][] T;
    T.length = N;
    foreach (_; 1..N) {
        auto uv = readln.split.to!(int[]);
        auto u = uv[0]-1;
        auto v = uv[1]-1;
        T[u] ~= v;
        T[v] ~= u;
    }
    if (N == K) {
        writeln(0);
        return;
    }

    int[] ls;
    auto ps = new int[](N);
    auto cs = new int[](N);
    auto ds = new int[](N);
    auto es = new int[](N);
    auto bs = new bool[](N);

    int walk(int i, int p, int d) {
        ps[i] = p;
        ds[i] = d;
        int cn;
        foreach (j; T[i]) if (j != p) {
            cn += walk(j, i, d+1);
        }
        cs[i] = cn;
        if (cn == 0) {
            ls ~= i;
        }
        return cn + 1;
    }
    walk(0, -1, 0);

    auto pq = priority_queue!((a, b) => ds[a] - cs[a] > ds[b] - cs[b], int)();
    foreach (l; ls) pq.enqueue(l);
    while (K) {
        auto i = pq.dequeue();
        if (T[i].length.to!int-1 > es[i] || bs[i]) continue;
        bs[i] = true;
        auto p = ps[i];
        if (p != -1) {
            ++es[p];
            pq.enqueue(p);
        }
        --K;
    }
    int r;
    int count(int i, int p) {
        int s;
        foreach (j; T[i]) if (j != p) {
            s += count(j, i);
        }
        if (bs[i]) {
            s += 1;
        } else {
            r += s;
        }
        return s;
    }
    count(0, -1);
    writeln(r);
}