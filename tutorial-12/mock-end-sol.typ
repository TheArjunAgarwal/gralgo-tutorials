#import "../style.typ": *

#show: main.with(
  title: [Graduate Algorithms],
  subtitle: [Pre-Endsem Solutions],
  date: datetime.today(),
  report-style : false
)

#show raw : it => {
  set text(font : "Fira Code")
  it
}

= Solutions

#remark(title: "How to read these")[
  Each solution starts with a remark on where the problem came from, and has some more comments at the end. As usual, wherever I write "left to the reader" it means the reader should be able to do it in the exam in under two minutes. If you can't, that is the part to practise. Also, as the exam says, unstated assumptions are held against you, so notice that in several solutions below I spend a few lines stating the model before solving anything. That is deliberate and it is what I would like to see in your answers too.
]

#prob[
  Prof. Wuependra Wulkarni recently learned that we can compute $f^n (x)$ in $O(log n)$ calls to the function for some functions. This would provide an exponential speed up over the brute force $O(n)$ applications. 

  Wulkarni conjectures that this can be done to every function.

  (a) Prove that if Wulkarni's conjucture holds then $"P" = "NP"$

  (b) Give an argument to show that Wulkarni's conjecture doesn't hold.
]

#remark(title: "Source")[
  CMU's Computation & Discrete Math course, where it was named the "Wurzelbrunft Conjecture". 
  
  Prof. Dr. Alois Wurzelbrunft is a character used by Klaus Sutner. I
  
   replaced him by my own character, Prof. Wupendra Wulkarni. 
   
   This question also led to IMO 2019's P5 aka Bank of Bath. Story from the author David Altizio: https://artofproblemsolving.com/community/c6h1876772p12785720
]

(a) "apply $f$ exponentially many times" is exactly what brute force over all certificates would look like.

Let $phi$ be a 3-SAT formula on variables $x_1, dots, x_N$. Consider strings of the form $(phi, a, b)$ where $a in {0,1}^N$ is thought of as a number in $[0, 2^N)$ and $b in {0,1}$. Consider:
$
f(phi, a, b) = (phi, (a + 1) mod 2^N, b or phi(a)).
$
Evaluating $phi(a)$ takes $O(|phi|)$ time, so one call to $f$ takes $"poly"(|phi|)$ time. By induction, $f^k (phi, 0, 0) = (phi, k mod 2^N, b_k)$ where $b_k = 1$ iff some $a < k$ satisfies $phi$.

Hence $f^(2^N) (phi, 0, 0) = (phi, 0, b)$ with $b = 1$ iff $phi$ is satisfiable.

If the conjecture is true, we compute this using $O(log 2^N) = O(N)$ calls to $f$ and $"poly"(N, |phi|)$ extra time. Each call is $"poly"(|phi|)$ time and the strings are of length $O(|phi| + N)$, so the total is $"poly"(|phi|)$ time. So 3-SAT $in$ P, and as 3-SAT is NP-complete, $"P" = "NP"$. #h(1fr) $square$

(b) We give two arguments. Neither needs $"P" != "NP"$ or the Time Hierarchy Theorem.

*Argument 1: the output is too long.* Take $f(x) = x x$ (concatenate $x$ with itself). It is as simple as a function can be. Then $f^n (x)$ is $x$ written $2^n$ times, with length $2^n |x|$.

Suppose an algorithm computes $f^n (x)$ using at most $c log n$ calls and at most $R = "poly"(log n, |x|)$ time outside the calls. Let $M_k$ be the length of the longest string it has seen after $k$ calls. Strings are either the input, written by the algorithm itself (at most $R$ symbols in total), or returned by a call, in which case they are at most twice as long as the argument. So
$
M_k <= 2 (M_(k-1) + R) quad ==> quad M_(c log n) <= 2^(c log n) (|x| + 2R) = n^c dot "poly"(log n, |x|).
$
But the output has to have length $2^n |x|$, which is way more than $n^c "poly"(log n, |x|)$ for large $n$. We didn't even charge the algorithm for the time spent inside the calls. So no such algorithm exists for this $f$, and the conjecture is false.

*Argument 2: if $f$ is a black box (the information theoretic version).* Say the algorithm only gets to call $f$ as an oracle, even for $f : NN -> NN$. We claim that computing $f^n (0)$ needs at least $n$ calls, so $O(log n)$ is impossible.

Run an adversary which answers every query of the algorithm $y$ with $y + 1$. After $q < n$ queries, consider the chain $c_0 = 0, c_1 = 1, dots$ The first element $c_d$ of this chain that was never queried has $d <= q < n$ (otherwise the algorithm queried $n$ distinct points). Let $u != v$ be two huge numbers such that $[u, u+n]$ and $[v, v+n]$ are disjoint from each other and from all queried points. Define $f$ and $f'$ as: they agree with the answers on queried points, $f(c_d) = u$ and $f'(c_d) = v$, and $f(w) = f'(w) = w + 1$ on every other point. Both are consistent with everything the algorithm has seen, yet $f^n (0) = u + (n - d - 1)$ and $f'^n (0) = v + (n - d - 1)$ are different. So the algorithm is wrong on one of them. #h(1fr) $square$

#remark(title: "What does work, and what the hint's route looks like")[
  The conjecture is false, but it is not silly, which is why it is a good trap. For *special* functions, $f^n (x)$ really is computable in $O(log n)$ steps, by repeated squaring: compute $f^2 = f compose f$, then $f^4 = f^2 compose f^2$, and so on, and combine the right powers according to the binary expansion of $n$. This works whenever $f$ has a *compact description which is closed under composition*:
  - $f(x) = a x + b mod p$: the composition of two such maps is again of this form, so $f^n$ is again two numbers. (This is how you compute the $n$-th term of a linear congruential generator quickly.)
  - $f$ is a linear map $v |-> M v$: $f^n$ is the matrix $M^n$. This is how Fibonacci numbers are computed in $O(log n)$ arithmetic steps.
  The conjecture asks for this for _every_ $f$, including those where $f compose f$ has no description shorter than a table. Both arguments above are really saying that: $f(x) = x x$ has the property that $f^n$ has no short description at all (its output is exponentially long), and in the oracle model the compositions of an arbitrary $f$ carry no information beyond what you get by following the chain.

  The hint's route is the "complexity" version of part (a) taken to its conclusion. Part (a) already shows that a step function whose $2^N$-th power solves SAT would put SAT in P. The same idea applied to the step function of an exponential-time Turing machine would give $"P" = "EXP"$, which contradicts the Time Hierarchy Theorem, so such a conjecture cannot hold unconditionally. I have not written it out, since encoding the configuration of a machine that uses exponential space needs more care, and the two arguments above are shorter and don't depend on any unproven or heavy theorem. Notice also that Argument 1 and Argument 2 attack different readings of the conjecture (the "time" reading and the "oracle" reading), so between them neither reading survives.

  Finally, notice how much of the work in this question is to just pin down the statement. Without "poly extra time" the conjecture in part (a) is vacuous, and without "length preserving" the composition in part (a) could blow up the intermediate strings. In an exam, state those assumptions.
]

#prob[
  *(Fury's squad)*
]

#remark(title: "Source")[
  A reskin of a problem from the 16th Polish Collegiate Programming Contest (2011), authored by the legendary Marek Cygan (you'll hear his name quite a few times if you take Parametrized Algorithms next year, which I recommend as a course). The original was about picking the heaviest set of mutually compatible items, and the Avengers/X-Men are just the two sides of the bipartite graph.
]

*Modelling.* (The statement says `bestSquad(C, D, E, g)`, I'll call the groups $A$ and $B$ as in the problem.) Any two Avengers get along and any two X-Men get along, so the only obstructions to a valid squad are the feuds in $E$. In other words, a valid squad is exactly an independent set in the bipartite graph $H = (A union B, E)$, and we want the maximum weight independent set in a bipartite graph. For bipartite graphs this is the complement of a minimum weight vertex cover, which is a min-cut.

(a) Build the flow network $N$: a source $s$, a sink $t$, a node for each hero, and
- an edge $s -> a$ of capacity $g(a)$ for each $a in A$,
- an edge $b -> t$ of capacity $g(b)$ for each $b in B$,
- an edge $a -> b$ of capacity $infinity$ (we use $1 + sum_h g(h)$) for each $(a,b) in E$.

For the running time, we first throw away the heroes who are in no feud. They can always be added to any squad, so they are always in the optimal squad. Call this set $I$.

#psudo(title: "Best Squad")[
+ def bestSquad($A, B, E, g$):
  + $I$ = heroes in $A union B$ not appearing in any pair of $E$
  + $A' = A without I$, $B' = B without I$
  + $"INF" = 1 + sum_h g(h)$
  + create the network $N$ on vertices ${s, t} union A' union B'$ with
    + $c(s, a) = g(a)$ for $a in A'$
    + $c(b, t) = g(b)$ for $b in B'$
    + $c(a, b) = "INF"$ for $(a, b) in E$
  + $(f, R) =$ EDMONDSKARP($N, s, t, c$)
  + $S =$ BFS($R, s$) #h(1em) *Comment:* vertices reachable from $s$ in the residual graph
  + return $I union (A' inter S) union (B' without S)$
]

(b) *Correctness.* Let $W = sum_h g(h)$. Cuts here are of the form $(S, overline(S))$ with $s in S$ and $t in.not S$.

#claim[
  For every valid squad $T$ there is a cut of capacity $W - g(T)$ (restricted to $A' union B'$, with $T$ replaced by $T inter (A' union B')$). Conversely, every cut of capacity less than $"INF"$ gives a valid squad $T$ with $g(T) = W - "capacity"$.
]
To keep notation light, assume $I = emptyset$ in the proof (heroes in $I$ contribute the same constant to both sides).

#proof[
  ($T -> "cut"$) Let $T$ be a valid squad. Put $S = {s} union (T inter A) union (B without T)$. The edges leaving $S$ are:
  - $s -> a$ for $a in A without T$: capacity $g(A without T)$.
  - $b -> t$ for $b in B without T$ (these $b$ are in $S$): capacity $g(B without T)$.
  - $a -> b$ with $a in S$ and $b in.not S$, so $a in T$ and $b in T$ and $(a,b) in E$. Such an edge would be a feuding pair inside $T$. So there is none.

  So the capacity is $g(A without T) + g(B without T) = W - g(T)$.

  (cut $-> T$) Let $(S, overline(S))$ be a cut of capacity $< "INF"$. Put $T = (A inter S) union (B without S)$. No infinite edge leaves $S$, so there is no $(a,b) in E$ with $a in S$ and $b in.not S$, i.e. no feuding pair inside $T$, so $T$ is valid. The edges crossing the cut are $s -> a$ for $a in A without S$ and $b -> t$ for $b in B inter S$, which is exactly the heroes outside $T$. So the capacity is $W - g(T)$.
]

So valid squads of power $p$ correspond to cuts of capacity $W - p$ (and the finite cuts are all that matter: the cut $({s}, "rest")$ has capacity at most $W < "INF"$, so the minimum cut is finite). By the max-flow min-cut theorem, the set $S$ of vertices reachable from $s$ in the residual graph of a maximum flow is a minimum cut. It is finite, so by the claim the squad we return has power $W - "mincut"$, and no squad has more power as that would give a smaller cut. Heroes in $I$ are included, as they conflict with nobody and $g >= 0$. If $E = emptyset$ we return everyone, which is clearly optimal.

*Running time.* If $E = emptyset$ we are done in $O(m+n)$, so assume $|E| >= 1$. Finding $I$ and building $N$ takes $O(m + n + |E|)$.

Every hero in $A' union B'$ is in at least one feud, so $|A'| + |B'| <= 2|E|$. Hence $N$ has $<= m + n + 2$ vertices and $<= |E| + |A'| + |B'| <= 3|E|$ edges. Edmonds-Karp runs in $O(|V||E|^2)$ so here it takes
$
O((m + n + 2) dot (3 |E|)^2) = O((m + n) |E|^2).
$
The BFS and the final assembly take $O(m + n + |E|)$. Hence the total is $O((m+n)|E|^2)$ (as $|E| >= 1$). #h(1fr) $square$

#remark(title: "Why the isolated heroes, a tiny example, and the bigger picture")[
  *Why remove them.* The reason for removing the isolated heroes is to make $|E_N| = O(|E|)$. If we did not, $|E_N|$ could be as large as $m + n$, which can be much more than $|E|$, and Edmonds-Karp would take $O((m+n)^3)$ instead of $O((m+n)|E|^2)$. It costs nothing to remove them because they conflict with nobody. Two small things worth knowing: the running time of Edmonds-Karp does not depend on the capacities, so the huge "infinite" capacity (and large power levels) cost nothing; and $g(h) = 0$ is harmless because a hero of power zero is just a free rider on either side of the cut.

  *A tiny example.* Let $A = {a_1, a_2}$, $B = {b_1}$ with $g(a_1) = 5$, $g(a_2) = 1$, $g(b_1) = 4$ and a single feud $(a_1, b_1)$. Then $a_2$ is isolated, so $I = {a_2}$. The network is $s -> a_1$ (capacity $5$), $a_1 -> b_1$ (capacity $infinity$), $b_1 -> t$ (capacity $4$). The max flow is $4$, saturating $b_1 -> t$, and in the residual graph $s$ can still reach $a_1$ (residual capacity $1$) and then $b_1$ through the infinite edge. So $S = {s, a_1, b_1}$ and we return $I union (A' inter S) union (B' without S) = {a_2} union {a_1} union emptyset$, of power $6$. The other candidate $a_2, b_1$ has power only $5$.

  *The bigger picture.* "Maximum weight independent set in a bipartite graph = total weight $-$ minimum weight vertex cover = a min-cut" is the weighted version of Konig's theorem. In the unweighted case it becomes $|V| - $ (maximum matching), which is the more familiar statement, and the flow network above is the usual way to compute it. The reason this particular graph is bipartite is the key observation of the problem: all the feuds go between the two groups, as people within a group get along. Independent set is NP-hard in general, so spotting the structure that makes it easy is the question.
]

#prob[
  *(Dholakpur)* Spanning trees with prescribed leaves.
]

#remark(title: "Source")[
  Classic. The three parts are three versions of "choose the leaves of a spanning tree", and the point of the question is that tiny changes in the requirement flip the problem from polynomial to NP-complete.
]

(a) *Polynomial.* Claim: there is a spanning tree in which every vertex of $F$ is a leaf iff
+ $V without F != emptyset$, and $G[V without F]$ is connected, and
+ every $v in F$ has a neighbour in $V without F$.

#proof[
  ($arrow.l.double$) Take a spanning tree $T_0$ of $G[V without F]$ (exists by 1). For each $v in F$ add one edge from $v$ to a neighbour outside $F$ (exists by 2). This is a tree on $V$ in which each $v in F$ has degree $1$.

  ($arrow.r.double$) Let $T$ be such a tree. Since $n >= 3$, $T$ has a vertex which is not a leaf, so $V without F != emptyset$. If $v in F$ were adjacent in $T$ to another leaf $u$, then $T$ would be just the edge $u v$ (both being leaves), contradicting $n >= 3$. So the unique neighbour of $v$ in $T$ is in $V without F$, giving 2. Removing leaves from a tree leaves a tree (connected), so $T - F$ is a connected spanning subgraph of $G[V without F]$, giving 1.
]

*Algorithm:* check the conditions: run BFS in $G[V without F]$ from any of its vertices and check it reaches all of $V without F$, and scan the adjacency list of each vertex in $F$. This is $O(n + m)$.

(b) *NP-complete.* The problem is in NP: the certificate is $T$; we check it is a spanning tree and compute its leaves in $O(n+m)$.

For hardness, reduce from Hamiltonian Path between $s$ and $t$: given $(G, s, t)$ output $(G, F = {s, t})$.

- If $G$ has a Hamiltonian path from $s$ to $t$, the path is a spanning tree and its leaves are exactly its two endpoints $s, t$.
- Conversely, if $T$ is a spanning tree with leaf set exactly ${s,t}$, then $T$ is a tree with exactly two leaves, which is a path (a tree with $>= 3$ vertices and max degree $>= 3$ has $>= 3$ leaves, so max degree is $2$, i.e. a path). It is spanning with endpoints $s$ and $t$: a Hamiltonian $s$-$t$ path.

The reduction is $O(1)$. #h(1fr) $square$

(c) *NP-complete.* (This is the Maximum Leaf Spanning Tree problem.) It is in NP as above (certificate: $T$, count leaves).

For hardness we reduce from Dominating Set: given $(G = (V, E), k)$ with $|V| = n >= 3$ and $1 <= k <= n$, is there a $D subset.eq V$, $|D| <= k$ such that every vertex is in $D$ or adjacent to something in $D$?

First, a useful fact: in a connected graph $H$ on $>= 3$ vertices,

#claim[
  $H$ has a spanning tree with $>= L$ leaves iff $H$ has a connected dominating set (CDS) of size $<= |V(H)| - L$.
]
#proof[
  ($arrow.r.double$) Let $T$ be such a tree. Its internal vertices are connected (removing leaves from a tree keeps it a tree) and non-empty (as $|V(H)| >= 3$). Every leaf is adjacent to an internal vertex (its parent, which is internal as $|V(H)| >= 3$), so they dominate. There are $<= |V(H)| - L$ internal vertices.

  ($arrow.l.double$) Let $D$ be a CDS. Take a spanning tree of $H[D]$ and attach every vertex outside $D$ to a neighbour in $D$. All the vertices outside $D$ are leaves so there are at least $|V(H)| - |D|$ leaves.
]

Now build $G'$:
- vertices $V union V'$ where $V' = {v' : v in V}$ is a fresh copy of $V$,
- make $V$ into a *clique*,
- connect $v'$ to every vertex of $N[v]$, the closed neighbourhood of $v$ in $G$ (so $v' tilde v$ and $v' tilde u$ for each $u tilde v$ in $G$). $V'$ is an independent set.

$G'$ is connected (as $v' tilde v$ and $V$ is a clique) and has $2n >= 6$ vertices. We output $(G', 2n - k)$. By the claim, we need to show:

#claim[
  $G$ has a dominating set of size $<= k$ iff $G'$ has a connected dominating set of size $<= k$.
]
#proof[
  ($arrow.r.double$) Let $S$ be a dominating set of $G$, $1 <= |S| <= k$. In $G'$, $S$ is a clique, so connected. It dominates all of $V$ (clique, $S != emptyset$). It dominates each $u'$ since $S inter N[u] != emptyset$ and $u'$ is adjacent to all of $N[u]$.

  ($arrow.l.double$) Let $D$ be a CDS of $G'$ with $|D| <= k$. Let $hat(D) = (D inter V) union {v : v' in D}$, so $|hat(D)| <= k$. For any $u in V$, the vertex $u'$ is dominated by $D$: either $u' in D$ (so $u in hat(D)$) or some neighbour of $u'$, which lies in $N[u] subset.eq V$, is in $D$. Either way $hat(D) inter N[u] != emptyset$, i.e. $hat(D)$ is a dominating set of $G$. (We did not need connectivity here.)
]

The construction takes $O(n + m)$ time. Hence $G$ has a dominating set of size $<= k$ iff $G'$ has a spanning tree with $>= 2n - k$ leaves. #h(1fr) $square$

#remark(title: "Why n >= 3, and why these three behave so differently")[
  The assumption $n >= 3$ is used in (a) and (c). For $n = 2$ the single edge is a tree whose two vertices are leaves adjacent to each other, and all the arguments of the form "a leaf is adjacent to an internal vertex" fail.

  The three parts look similar but sit in very different places:
  - In (a), "every vertex of $F$ is a leaf" is a *one-sided* constraint: leaves outside $F$ are allowed. The set $V without F$ then just needs to be connected, which is a local condition, and we can build the tree greedily.
  - In (b), "the leaves are exactly $F$" is a *two-sided* constraint. The vertices outside $F$ now have to be internal, which makes the tree a connected structure with no leaves among them. When $|F| = 2$ this is precisely a Hamiltonian path. Notice how the reduction works by restricting the problem to $F = {s, t}$: showing a special case of your problem is hard is the cheapest NP-hardness proof there is.
  - In (c), we don't prescribe which vertices are leaves, only how many. This is the Maximum Leaf Spanning Tree problem, and it is NP-hard even though a polynomial-time algorithm can find a tree with at least half the optimal number of leaves (a known 2-approximation exists). It also becomes tractable when $k$ is a small constant (a *fixed parameter tractable* problem), which is the kind of thing you will see if you take Parametrized Algorithms.

  Also notice that the reduction in (c) is *not* from Hamiltonian Path. Hamiltonian Path wants *few* leaves (two), and (c) asks for *many* leaves, so the two are pulling in opposite directions. That is why we go through (connected) dominating sets: the internal vertices of a spanning tree are exactly a connected dominating set, so many leaves means a small connected dominating set.
]

#prob[
  *(Luffy and Zoro)*
]

#remark(title: "Source")[
  A reskin of a problem from the 19th Polish Collegiate Programming Contest (2014), authored by Jakub Łącki.
]

*Modelling.* Luffy can only change who helms what at islands. Between two consecutive islands at which the assignment is chosen, the assignment is fixed, so Luffy helms either all of the North-South travel or all of the East-West travel of that leg. (He may of course choose not to change anything at an island, so the islands which the ship merely passes over don't matter.) Let the islands on the route where the assignment is chosen be $v_0 = 1, v_1, dots, v_k = n$.

Going from $p = (x_p, y_p)$ to $q = (x_q, y_q)$, the ship travels at least $|x_p - x_q|$ horizontally and at least $|y_p - y_q|$ vertically. Luffy helms one of them, so he spends at least $w(p, q) := min(|x_p - x_q|, |y_p - y_q|)$ hours on this leg, and this is achieved by sailing straight along the $L$-shaped path and letting Luffy helm the shorter side. So the answer is the *shortest path from island $1$ to island $n$ in the complete graph with edge weights $w$*.

(a) The complete graph has $Theta(n^2)$ edges, too many. We only keep $O(n)$ of them.

#psudo(title: "Luffy's Route")[
+ def route($P$):
  + $X$ = islands sorted by $x$-coordinate
  + $Y$ = islands sorted by $y$-coordinate
  + create a graph $H$ on the islands, with no edges
  + for $i$ in $1, dots, n-1$:
    + for $(p, q) in {(X[i], X[i+1]), (Y[i], Y[i+1])}$:
      + add the undirected edge $p q$ with weight $w(p,q) = min(|x_p - x_q|, |y_p - y_q|)$
  + return DIJKSTRA($H, 1, n$) #h(1em) *Comment:* the path can be recovered from the Dijkstra tree
]

(b) *Running time.* Sorting is $O(n log n)$ (MERGESORT on keys, carrying the island along). $H$ has $n$ vertices and $<= 2(n-1)$ edges. Dijkstra takes $O((m' + n) log n) = O(n log n)$. Total $O(n log n)$.

*Correctness.* Let $d_K$ be the distance in the complete graph $K$ (with weights $w$) and $d_H$ the distance in $H$. Since $H subset.eq K$ with the same weights, $d_H >= d_K$. We show $d_H <= d_K$.

#claim[
  For any two islands $p, q$, $d_H (p,q) <= w(p,q)$.
]
#proof[
  Suppose $w(p,q) = |x_p - x_q|$, i.e. $|x_p - x_q| <= |y_p - y_q|$. (The other case is symmetric, using $Y$.) Let $p = r_0, r_1, dots, r_j = q$ be the islands between them in the sorted order $X$ (consecutive in $X$, ties in $x$ broken arbitrarily; the $x$-coordinates are monotone along this sequence). Each $r_i r_(i+1)$ is an edge of $H$ of weight $<= |x(r_i) - x(r_(i+1))|$. Summing, since the $x$-coordinates are monotone,
  $
  d_H (p,q) <= sum_i |x(r_i) - x(r_(i+1))| = |x_p - x_q| = w(p,q).
  $
]

Now take a shortest path in $K$ from $1$ to $n$. Replace each of its edges $p q$ by a path in $H$ of length $<= w(p,q)$. We get a walk in $H$ of length $<= d_K (1, n)$, so $d_H <= d_K$. Hence $d_H = d_K$, which is the answer. Dijkstra applies as the weights are non-negative. #h(1fr) $square$

#remark(title: "Why one needs the sparsification, and why the weights need Dijkstra")[
  *Modelling.* The statement is a little loose about how the ship may turn, so I fixed the model at the start of the solution: Luffy can only change who helms what at an island, the ship may pass islands without stopping, and the ship may turn at sea (it can only sail parallel to the axes). With the other reading (the ship must travel along straight lines between islands), the shortest path would be on a different graph. The structure of the solution, however, stays the same: "complete graph with a simple weight function, then keep only $O(n)$ useful edges".

  *The weights are not a metric.* The edge weight $w(p,q) = min(|x_p - x_q|, |y_p - y_q|)$ does not satisfy the triangle inequality, so going directly is not always best. Take $p = (0,0)$, $r = (10, 0)$, $q = (10,10)$. Then $w(p, q) = 10$, but $w(p, r) = 0$ (Luffy lets Zoro take the east-west leg) and $w(r, q) = 0$ (Luffy lets Zoro take the north-south leg), so the route through $r$ costs $0$. That's why we need an actual shortest path and not just the direct hop.

  *The sparsification trick.* The key claim, $d_H (p,q) <= w(p,q)$, says that every "long jump" can be simulated by short hops between neighbours in the sorted order, without losing anything. It works because both $|x_p - x_q|$ and $min(dots)$ are bounded by the same telescoping sum along the sorted sequence. This is a standard trick whenever the weight is a min of 1-dimensional distances. (It would *not* work for the max of the two, or for the sum.) It is also the reason the hint says that $O(n log n)$ is "$O(V log V)$": the graph has $O(V)$ edges, so Dijkstra with a binary heap costs the same as the sort.
]

#prob[
  *(Leaking tanks)*
]

#remark(title: "Source")[
  It is the textbook scheduling problem of minimising the weighted sum of completion times; the answer below is usually credited to Smith.
]

(a) Sort the tanks by $t_i / s_i$ in non-decreasing order (Smith's rule). To avoid division, compare $i$ before $j$ iff $t_i s_j < t_j s_i$ (ties broken by index).

#psudo(title: "Schedule")[
+ def Schedule($t, s$):
  + $pi$ = $[1, 2, dots, n]$
  + sort $pi$ with comparator: $i prec j$ iff $t_i s_j < t_j s_i$ or ($t_i s_j = t_j s_i$ and $i < j$)
  + return $pi$
]

(b) The comparator is $O(1)$, so a merge sort takes $O(n log n)$. (Comparisons are consistent: they're comparisons of the numbers $t_i / s_i$, then of indices, so it is a total order.)

(c) *Correctness.* Let $sigma$ be the order returned by Schedule. We say a pair of tanks $i, j$ is an *inversion* of a schedule $pi$ if $j prec i$ in the order above but $i$ appears before $j$ in $pi$.

*Swap lemma.* Let $i, j$ be adjacent in $pi$ with $i$ immediately before $j$, and let $P$ be the total time of the repairs before them. Swapping them changes only the completion times of $i$ and $j$, and the loss of these two is
$
"i first:" & s_i (P + t_i) + s_j (P + t_i + t_j)\
"j first:" & s_j (P + t_j) + s_i (P + t_j + t_i)
$
The difference ($i$ first minus $j$ first) is $s_j t_i - s_i t_j$. So when $t_i / s_i >= t_j / s_j$, that is, when $t_i s_j >= t_j s_i$, putting $j$ first is no worse; and the loss is unchanged if the ratios are equal. All other tanks are untouched (their completion times are unchanged as $t_i + t_j$ is the same).

*Main argument.* Among all optimal schedules, pick $pi$ with the fewest inversions. Suppose it has an inversion. Then it has an *adjacent* inversion (if $pi != sigma$ as sequences, there are adjacent positions $i, j$ with $j prec i$, otherwise $pi$ would be increasing in $prec$, so it equals $sigma$ since $prec$ is a total order). Swapping this adjacent pair places $j$ before $i$, i.e. in the right order, as $j prec i$ means $t_j s_i <= t_i s_j$. By the swap lemma the loss does not increase, so the new schedule is also optimal, and it has exactly one inversion fewer (only the relative order of this pair changed). This contradicts the choice of $pi$. Thus $pi$ has no inversions, so $pi = sigma$ and $sigma$ is optimal. #h(1fr) $square$

#remark(title: "A check, why not other greedy rules, and the intuition")[
  *Check on the example.* For $t = [2,1,3]$ and $s = [1,3,2]$ the ratios are $2, 1/3, 3/2$. So the order is $(2, 3, 1)$ with loss $3 dot 1 + 2 dot 4 + 1 dot 6 = 17$, which matches the better schedule in the statement.

  *Other greedy rules fail.* The two obvious rules are wrong, which is worth knowing when you are choosing an exchange argument to try.
  - Shortest repair first: $t = [1, 10]$, $s = [1, 100]$. Doing tank $1$ first loses $1 dot 1 + 100 dot 11 = 1101$. Doing tank $2$ first (ratios $1$ and $0.1$) loses $100 dot 10 + 1 dot 11 = 1011$.
  - Largest leak first: $t = [100, 1]$, $s = [2, 1]$. Doing tank $1$ first loses $2 dot 100 + 1 dot 101 = 301$, but the ratios $50$ and $1$ say do tank $2$ first, which loses $1 dot 1 + 2 dot 101 = 203$.
  Only the ratio $t_i / s_i$ balances both: it is the number of days you "pay" for each unit of daily leak that you remove.

  *Intuition for the swap lemma.* If $i$ is directly before $j$, then swapping them makes $j$ finish $t_i$ days earlier (saving $s_j t_i$ litres) and $i$ finish $t_j$ days later (costing $s_i t_j$ litres). Everything else is unchanged. That is all the computation above says. The "minimal number of inversions" trick in the main argument is just a clean way to say "bubble sort never makes things worse", and it also takes care of ties, as swapping two tanks with equal ratio changes nothing.
]

#prob[
  *(`kDndlm`)*
]

#remark(title: "Source")[
  Basic DnD stuff ig.
]

(a) Let `prob(k,n,m,x)` be the probability that the sum of the $k - m$ highest dice among $k$ rolls of an $n$-sided die is $x$.

The idea is to look at how many dice show the maximum value $n$, say $j$ of them. This happens with probability $binom(k, j) (1/n)^j ((n-1)/n)^(k-j)$. Conditioned on this, the remaining $k - j$ dice are independent and uniform on ${1, dots, n-1}$.

*Base cases:*
- If $m >= k$ (everything is dropped): `prob(k,n,m,x)` $= [x = 0]$.
- If $n = 1$ and $m < k$ (all dice show $1$): `prob(k,n,m,x)` $= [x = k - m]$.

*Recursion* ($m < k$, $n >= 2$):
$
"prob"(k,n,m,x) = sum_(j=0)^(k) binom(k,j) (1/n)^j ((n-1)/n)^(k-j) dot cases(
  [x = (k-m) n] & "if" j >= k - m,
  "prob"(k - j, n - 1, m, x - j n) & "if" j < k - m
)
$
where $[dot]$ is $1$ if the statement is true and $0$ otherwise (and `prob` of a negative $x$ is $0$).

(b) *Correctness.* Condition on $J$, the number of dice showing $n$; $J$ is binomial$(k, 1/n)$, which gives the weights. Given $J = j$, the dice not showing $n$ are iid uniform on $[1, n-1]$ (conditioning on a die being not $n$ makes it uniform on the rest).
- If $j >= k - m$, there are at least $k - m$ dice showing the maximum value $n$. The $m$ lowest dice dropped can be taken as all the non-$n$ dice and some of the $n$'s; the dice kept are $k - m$ copies of $n$, so the sum is exactly $(k - m) n$ (ties do not matter as dice of equal value are interchangeable).
- If $j < k - m$, then all the $j$ copies of $n$ are among the kept dice (they are the highest, and there are fewer than $k - m$ of them). The remaining $k - m - j$ kept dice are the highest $k - m - j$ of the remaining $k - j$ dice, i.e. we drop the lowest $(k - j) - (k - m - j) = m$ of them. This is exactly `(k-j)D(n-1)dl m`. So the total is $j n$ plus this, and we need it to be $x - j n$.

The cases partition the sample space by $j$ so the probabilities add up. Termination: in the recursive call $n$ strictly decreases (and $k$ does not increase), so we end at the base cases ($n = 1$, or $k <= m$ as $k - j > m$ always in recursive calls).

(c) *Complexity.* Note that $m$ never changes in the recursion. The states are $(k', n', x')$ with $k' <= k$, $n' <= n$ and $0 <= x' <= k' n'$. That is $sum_(k' <= k) sum_(n' <= n) k' n' = O(k^2 n^2)$ states. Each state does a sum over $j in [0, k']$, so $O(k')$ work each (assuming arithmetic is $O(1)$ and the binomials $binom(k', j)$ and the powers of $1/n'$ and $(n'-1)/n'$ are precomputed in $O(k^2 + k n)$ time). In total
$
sum_(k' <= k) sum_(n' <= n) k'^2 n' = O(k^3 n^2).
$
So the DP runs in $O(k^3 n^2)$ time (and $O(k^2 n^2)$ memory).

#remark(title: "A sanity check, and other ways to set it up")[
  *Sanity check.* Take `2D2dl1`, i.e. roll two coins labelled $1$ and $2$ and keep the larger one. Directly, $P(1) = 1/4$ and $P(2) = 3/4$. By the recursion with $k = 2, n = 2, m = 1$: the term $j = 0$ has weight $(1/2)^2 = 1/4$ and, as $0 < k - m = 1$, it contributes `prob(2,1,1,x)`, which is $[x = 1]$ by the $n = 1$ base case. The term $j = 1$ has weight $2 dot 1/2 dot 1/2 = 1/2$ and gives $[x = 2]$, and $j = 2$ has weight $1/4$ and gives $[x = 2]$. In total $P(1) = 1/4$ and $P(2) = 1/2 + 1/4 = 3/4$. Check.

  *Other recursions.* There are other natural ways to set this up. You can condition on the *lowest* value instead (how many dice show $1$), which is the mirror image: those are exactly the first dice to be dropped, and you remove $m$ minus (number of ones) from the drop count, and shift all the remaining dice down by one. Or you can sort the dice and think of the order statistics. The version above is the one where the "drop the lowest $m$" bookkeeping is easiest to argue: a die showing the maximum is either kept (if there aren't too many of them) or the sum is already determined.

  *Why condition on $n$ and not on the first die.* Conditioning on "the first die shows $v$" does not work well: we'd need to remember whether $v$ gets dropped, which depends on the other dice. Conditioning on the number of maxima avoids this, as the maxima are always the last to be dropped.

  *Precision.* In an implementation you can use exact fractions (the denominators are powers of $n$) or floating point. The recursion only multiplies and adds non-negative numbers, so there is no cancellation and floating point is fine.
]

#prob[
  *(Clock-it club)*
]

#remark(title: "Source")[
  Inspired by CMI's very own Clock It Club. I had joked that if the club gets going, I'll make a problem on it and this is what I came up with. I also had something along the lines where you had to count the number of ways $n$ people could make a total of $m$ clocks (inspired by the hardest problem on JEE Adv 2026; it was not that hard, people just don't teach math well at coaching level and this being a little non-standard screwed most of the kids. Their question was $n = 10$ and $m = 42$, you'll probably solve it in a jiffy). But doing it very fast ($O(n log n + m log m)$) needs a bit more interesting ideas (Newton iteration and exponential generating functions) that Prof. Samir wouldn't allow me to put, so that was shelved and instead this one, which is a bit easier, was given.
]

*Modelling.* The rules say that "clocks" is a relation on people which is
- reflexive (everyone clocks themselves),
- symmetric (if someone clocks you, you clock them),
- transitive (if you clock $b$ and $b$ clocks $c$, you clock $c$).

That is exactly an *equivalence relation*, and the sub-clubs are exactly its equivalence classes. So the number of ways to have exactly $m$ sub-clubs is the number of partitions of $n$ people into $m$ non-empty (unlabelled) sets, which is the Stirling number of the second kind $S(n, m)$.

(a) Condition on person $n$. Either they are alone in their sub-club, giving $S(n-1, m-1)$, or they join one of the $m$ sub-clubs formed by the other $n-1$ people, giving $m S(n-1, m)$.
$
S(i, j) = j S(i-1, j) + S(i-1, j-1), quad S(0,0) = 1, quad S(i, 0) = S(0, j) = 0 "otherwise".
$
Fill the table $S(i, j)$ for $i <= n$, $j <= m$ in $O(n m)$ time with $O(1)$ per entry. The answer is $S(n, m)$.

(b) *Inclusion-exclusion.* Count the surjections from the $n$ people to $m$ *labelled* sub-clubs. By inclusion-exclusion over the set of labels that are unused, this is
$
sum_(i=0)^m (-1)^(m - i) binom(m, i) i^n.
$
Each partition into $m$ blocks corresponds to exactly $m!$ labelled ones, so
$
S(n, m) = 1/(m!) sum_(i=0)^m (-1)^(m-i) binom(m, i) i^n = sum_(i=0)^m (i^n / i!) dot ((-1)^(m-i) / (m-i)!).
$

#psudo(title: "Count Partitions Mod p")[
+ def count($n, m$): #h(1em) *Comment:* all arithmetic mod $p = 998244353$
  + $"fact"[0] = 1$; $"fact"[i] = "fact"[i-1] dot i$ for $i = 1..m$
  + $"inv"[m] = "fact"[m]^(p-2)$ #h(1em) *Comment:* Fermat, valid as $m < p$ so $m!$ is non-zero mod $p$
  + $"inv"[i-1] = "inv"[i] dot i$ for $i = m..1$
  + total = 0
  + for $i$ in $0, dots, m$:
    + term = $"fact"[m] dot "inv"[i] dot "inv"[m-i] dot "power"(i, n)$ #h(1em) *Comment:* $binom(m, i) i^n$, fast exponentiation
    + total += $(-1)^(m-i) dot$ term
  + return total $dot "inv"[m]$ #h(1em) *Comment:* divide by $m!$
]

*Time:* the factorials are $O(m)$, the one Fermat inverse is $O(log p) = O(1)$, and each of the $m + 1$ values of $i^n$ is computed by repeated squaring in $O(log n)$. Total $O(m log n)$. (Note $m <= n$ since else the answer is $0$.)

(c) We want $S(n, m)$ for all $0 <= m <= n$. The last form of the formula is a convolution. Let
$
a_i = i^n / i!, quad b_k = (-1)^k / k!, quad "then" quad S(n, m) = sum_(i=0)^m a_i b_(m-i) = (a * b)_m.
$

#psudo(title: "All Stirling Numbers of Fixed n")[
+ def all_counts($n$): #h(1em) *Comment:* mod $p = 998244353$
  + compute $"fact"[0..n]$ and $"inv"[0..n]$ as before ($n < 2^23 < p$ so all are invertible)
  + $a[i] = "power"(i, n) dot "inv"[i]$ for $i = 0..n$
  + $b[k] = (-1)^k dot "inv"[k]$ for $k = 0..n$
  + $c$ = CONVOLVE($a, b$)
  + return $c[1..n]$ #h(1em) *Comment:* $c[m] = S(n, m)$
]

*Time:* $O(n)$ for the factorials and inverses, $n + 1$ fast exponentiations for a total of $O(n log n)$, and one CONVOLVE of two arrays of size $n + 1$ which costs $O(n log n)$. Total: $O(n log n)$. The entries $c[m]$ for $m <= n$ are exactly the sums above (the coefficients above $n$ are discarded). #h(1fr) $square$

#remark(title: "A check, the hint, and where this comes from")[
  *Check.* For $n = 4$, $m = 2$: $S(4, 2) = 1/2 (2^4 - 2 dot 1^4 + 0) = (16 - 2)/2 = 7$. Directly, the partitions of $4$ people into two groups are $4$ of type $3 + 1$ and $3$ of type $2 + 2$, which is $7$. Check.

  *The hint about the prime.* The hint about $998244353 = 1 + 7 dot 17 dot 2^23$ is the reason `CONVOLVE` (a number theoretic transform, which is the FFT done in $ZZ_p$ instead of over the complex numbers) works mod this prime for sizes up to $2^23$: you need a $2^k$-th root of unity $omega$ for the transform of size $2^k$, and in $ZZ_p$ these exist exactly when $2^k | p - 1$. Here we get to use it as a black box, which is the whole point of the question: spot that the inclusion-exclusion formula is a convolution. If this prime had not been given, you could still do the convolution over the integers with a slower or approximate method. That is why the problem insists on the modulus.

  *Why an equivalence relation.* The three rules of the club are literally the three axioms of an equivalence relation. Once you see it the problem is "count the partitions of an $n$-set into $m$ blocks", which has many classical answers: the DP of (a), the inclusion-exclusion of (b), and the exponential generating function $sum_n S(n, m) x^n / n! = (e^x - 1)^m / m!$ (the generating-function version is also what the shelved problem from the source remark at the top of this solution needed). The identity in (c) is just this generating function read off at the coefficient $x^n$ after expanding $(e^x - 1)^m$ with the binomial theorem.

  *On the cost of $i^n$.* In (c) we compute each $i^n$ by fast exponentiation, which is $O(n log n)$ in total and so is within budget. One can do better, since $i |-> i^n$ is completely multiplicative, and so we need to raise only the primes to the power $n$ and fill in the rest with a linear sieve, which brings this part down to $O(n)$. The convolution is the bottleneck anyway, so this does not change the answer.
]