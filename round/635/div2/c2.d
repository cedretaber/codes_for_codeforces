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

int[] ls;
int[10^^5*2] ps, cs, ds, es;
bool[10^^5*2] bs;

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

    auto stk1 = [[0, -1, 0]];
    int[] rs;
    while (!stk1.empty) {
        auto h = stk1[0];
        stk1 = stk1[1..$];
        auto i = h[0];
        auto p = h[1];
        auto d = h[2];

        rs ~= i;
        ps[i] = p;
        ds[i] = d;
        foreach (j; T[i]) if (j != p) {
            stk1 ~= [j, i, d+1];
        }
    }
    foreach_reverse (r; rs) {
        auto p = ps[r];
        if (p == -1) continue;
        cs[p] += cs[r] + 1;
        if (cs[r] == 0) {
            bs[r] = true;
            ++es[p];
            ls ~= r;
        }
    }

    if (K <= ls.length) {
        sort!((a, b) => ds[a] > ds[b])(ls);
        int r;
        foreach (l; ls[0..K]) r += ds[l];
        writeln(r);
    } else {
        K -= ls.length;
        auto pq = priority_queue!((a, b) => ds[a] - cs[a] > ds[b] - cs[b], int)();
        foreach (l; ls) if (ps[l] != -1) {
            pq.enqueue(ps[l]);
        }
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
        auto stk2 = [[0, -1]];
        rs = [];
        auto ss = new int[](N);
        while (!stk2.empty) {
            auto h = stk2[0];
            stk2 = stk2[1..$];
            auto i = h[0];
            auto p = h[1];
            rs ~= i;
            if (bs[i]) {
                ss[i] += 1;
            }
            foreach (j; T[i]) if (j != p) stk2 ~= [j, i];
        }
        foreach_reverse (x; rs) {
            auto p = ps[x];
            if (!bs[x]) r += ss[x];
            if (p != -1) ss[p] += ss[x];
        }
        writeln(r);
    }
}