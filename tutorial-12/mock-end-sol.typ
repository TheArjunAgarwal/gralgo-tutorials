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

#quote(attribution: "John Green")[
Yeah, about the test... The test will measure whether you are an informed, engaged, and productive citizen of the world, and it will take place in schools and bars and hospitals and dorm rooms and in places of worship. You will be tested on first dates, in job interviews, while watching football, and while scrolling through your Twitter feed. The test will judge your ability to think about things other than celebrity marriages, whether you'll be easily persuaded by empty political rhetoric, and whether you'll be able to place your life and your community in a broader context. The test will last your entire life, and it will be comprised of the millions of decisions that, when taken together, will make your life yours. And everything, everything, will be on it.
]

= Solutions

#prob[
  Prof. Wuependra Wulkarni recently learned that we can compute $f^n (x)$ in $O(log n)$ calls to the function for some functions. This would provide an exponential speed up over the brute force $O(n)$ applications. 

  Wulkarni conjectures that this can be done to every function.

  (a) Prove that if Wulkarni's conjucture holds then $"P" = "NP"$

  (b) Give an argument to show that Wulkarni's conjecture doesn't hold.
]

#remark(title: "Source")[
  This problem originates from CMU's Computation & Discrete Math course, where it was named the "Wurzelbrunft Conjecture". 
  
  Prof. Dr. Alois Wurzelbrunft is a character used by Prof. Klaus Sutner who taught that course. 
  
  I replaced him by my own character, Prof. Wupendra Wulkarni. 
   
   This question also led to IMO 2019's P5 aka Bank of Bath. Story from the author David Altizio (who was a student taking the said course): https://artofproblemsolving.com/community/c6h1876772p12785720
]

(a) We want to setup $f$ such that "apply $f$ exponentially many times" is exactly what brute force search over all certificates would look like. One way of doing it is as follows:

Let $phi$ be a 3-SAT formula on variables $x_1, dots, x_N$. Consider strings of the form $(phi, a, b)$ where $a in {0,1}^N$ is thought of as a number in $[0, 2^N)$ and $b in {0,1}$. We define
$
f(phi, a, b) := (phi, (a + 1) mod 2^N, b or phi(a)).
$
Evaluating $phi(a)$ takes $O(|phi|)$ time, so a call to $f$ takes $"poly"(|phi|)$ time. 

By induction, $f^k (phi, 0, 0) = (phi, k mod 2^N, b_k)$ where $b_k = 1$ iff some $a < k$ satisfies $phi$.

Hence $f^(2^N) (phi, 0, 0) = (phi, 0, b)$ with $b = 1 <==> phi$ is satisfiable.

If Wulkarni's conjecture is true, we compute this using $O(log 2^N) = O(N)$ calls to $f$. Each call is $"poly"(|phi|)$ time and the strings are of length $O(|phi| + N)$, so the total is $"poly"(|phi|)$ time. So 3-SAT $in$ P, and as 3-SAT is NP-complete, $"P" = "NP"$. #h(1fr) $square$

(b) We give two arguments. Neither use the Time Hierarchy Theorem.

*Argument 1* Take $f(x) = x x$ (concatenate $x$ with itself). It is as simple as a function can be. Then $f^n (x)$ is $x$ written $2^n$ times, with length $2^n |x|$.

Suppose an algorithm computes $f^n (x)$ using at most $c log n$ calls and at most $R = "poly"(log n, |x|)$ time outside the calls. Let $M_k$ be the length of the longest string it has seen after $k$ calls. Strings are either the input, written by the algorithm itself (at most $R$ symbols in total), or returned by a call, in which case they are at most twice as long as the argument. So
$
M_k <= 2 (M_(k-1) + R) quad ==> quad M_(c log n) <= 2^(c log n) (|x| + 2R) = n^c dot "poly"(log n, |x|).
$
But the output has to have length $2^n |x|$, which is way more than $n^c "poly"(log n, |x|)$ for large $n$. We didn't even charge the algorithm for the time spent inside the calls. 

So no such algorithm exists for this $f$, and the conjecture must be false.

*Argument 2:* Say the algorithm only gets to call $f$ as an oracle, even for $f : NN -> NN$. We claim that computing $f^n (0)$ needs at least $n$ calls, so $O(log n)$ is impossible.

Run an adversary which answers every query of the algorithm $y$ with $y + 1$. After $q < n$ queries, consider the chain $c_0 = 0, c_1 = 1, dots$ The first element $c_d$ of this chain that was never queried has $d <= q < n$ (otherwise the algorithm queried $n$ distinct points). 

Let $u != v$ be two huge numbers such that $[u, u+n]$ and $[v, v+n]$ are disjoint from each other and from all queried points. 

Define $f$ and $f'$ as follows: $f(c_d) = u$ and $f'(c_d) = v$, and $f(w) = f'(w) = w + 1$ on every other point. 

Both are consistent with everything the algorithm has seen yet. But $f^n (0) = u + (n - d - 1)$ and $f'^n (0) = v + (n - d - 1)$ are different. So the algorithm is wrong on one of them. #h(1fr) $square$

#remark[
  The conjecture is false, but it is not silly. 
  
  For _special_ functions, $f^n (x)$ really is computable in $O(log n)$ steps, by repeated squaring. 
  
  You can check out Prof. Sutner's slides on the same for more details: https://www.cs.cmu.edu/~cdm/resources/30-iteration.pdf
]

#remark[
  The hint's idea is part (a) taken to its conclusion. Part (a) already shows that a step function whose $2^N$-th power solves SAT would put SAT in P. 
  
  The same idea applied to the step function of an exponential-time Turing machine would give $"P" = "EXP"$, which contradicts the Time Hierarchy Theorem. 

  A bit more care is needed in the encoding and all, you can see from it on Dragomir Grozev's blog (the other parts of this series are also really cool): https://dgrozev.wordpress.com/2019/08/19/np-problems-wurzelbrunfts-conjecture-and-the-bank-of-bath-part-iii/
]

#prob[
  Doom is coming, and Nick Fury is putting together a strike team from two groups of heroes: the Avengers and the X-Men. There are $m$ Avengers, forming a set $A$, and $n$ X-Men, forming a set $B$. Nobody belongs to both groups.

  Fury knows the power level $g(h) in ZZ_(>=0)$ of every hero $h$, and he wants the team with the largest possible total power. 

  However, the team has to function in battle, so no two members may be feuding. The relationships between heroes are as follows:

  - Any two Avengers get along, and any two X-Men get along.
  - Some Avenger-X-Men pairs do *not* get along. These feuds are given as a set $E subset.eq A times B$, where $(a, b) in E$ means that $a$ and $b$ are feuding (this is mutual).
  - All other Avenger-X-men pairs get along.

  A set $T subset.eq A union B$ is a *valid squad* if it contains no feuding pair, i.e. there is no $(a, b) in E$ with $c,d in T$. Its *power* is $sum_(h in T) g(h)$.

  (a) Write a program `bestSquad(C, D, E, g)` that returns a valid squad of maximum power. Your algorithm must run in $O((m+n)|E|^2)$ time.

  (b) Prove that your algorithm is correct, and that its running time is indeed $O((m+n)|E|^2)$.
]

#remark(title: "Source")[
  This is a reskin of a problem from the 16th Polish Collegiate Programming Contest (2011), authored by the legendary Marek Cygan (you'll hear his name quite a few times if you take Parametrized Algorithms next year, which I recommend if you enjoyed algorithms).

  The problem was communicated to me by the legendary (and sadly untranslated) "Looking For A Challenge 2".
]

A valid squad is exactly an independent set in the bipartite graph $H = (A union B, E)$, and we want the maximum weight independent set in a bipartite graph.

Notice, we can think that every feud is blocking one member from taking part. If we turn this around, every person we don't take is blocking the feuds they are involved in from happening. Isn't that a vertex cover?

So the maximum weight independent set corresponds to the complement of the minimum weight vertex cover.

Now, by Konig's Theorem, we have a way to find the minimum weight cover using minCut-maxFlow!

(a) Build the flow network $N$: a source $s$, a sink $t$, a node for each hero, and
- an edge $s -> a$ of capacity $g(a)$ for each $a in A$,
- an edge $b -> t$ of capacity $g(b)$ for each $b in B$,
- an edge $a -> b$ of capacity $infinity$ for each $(a,b) in E$.

For the running time, we first throw away the heroes who are in no feud. They can always be added to any squad, so they are always in the optimal squad. Call this set $I$.

#psudo(title: "Best Squad")[
+ def bestSquad($A, B, E, g$):
  + $I$ = heroes in $A union B$ not appearing in any pair of $E$
  + $A' = A without I$, $B' = B without I$
  + create the network $N$ on vertices ${s, t} union A' union B'$ with
    + $c(s, a) = g(a)$ for $a in A'$
    + $c(b, t) = g(b)$ for $b in B'$
    + $c(a, b) = "INF"$ for $(a, b) in E$
  + $(f, R) =$ EDMONDSKARP($N, s, t, c$)
  + $S =$ BFS($R, s$) #h(1em) *Comment:* vertices reachable from $s$ in the residual graph
  + return $I union (A' inter S) union (B' without S)$
]

(b) *Correctness.* Let $W = sum_h g(h)$. Cuts are of the form $(S, overline(S))$ with $s in S$ and $t in.not S$.

#claim[
  For every valid squad $T$ there is a cut of capacity $W - g(T)$ (restricted to $A' union B'$, with $T$ replaced by $T inter (A' union B')$). Conversely, every cut of capacity less than $oo$ gives a valid squad $T$ with $g(T) = W - "capacity"$.
]
WLOG, assume $I = emptyset$ (heroes in $I$ contribute the same constant to both sides).

#proof[
  ($==>$) Let $T$ be a valid squad. Let $S := {s} union (T inter A) union (B without T)$. The edges leaving $S$ are:
  - $s -> a$ for $a in A without T$: capacity $g(A without T)$.
  - $b -> t$ for $b in B without T$ (these $b$ are in $S$): capacity $g(B without T)$.
  - $a -> b$ with $a in S$ and $b in.not S$, so $a in T$ and $b in T$ and $(a,b) in E$. Such an edge would be a feuding pair inside $T$. So there is none.

  So the capacity of cut is $g(A without T) + g(B without T) = W - g(T)$.

  ($<==$) Let $(S, overline(S))$ be a cut of capacity $< oo$. Let $T = (A inter S) union (B without S)$. No infinite edge leaves $S$, so there is no $(a,b) in E$ such that $a in S$ and $b in.not S$, tht is there is no feuding pair inside $T$, so $T$ is valid. 
  
  The edges crossing the cut are $s -> a$ for $a in A without S$ and $b -> t$ for $b in B inter S$, which is exactly the heroes outside $T$. So the capacity is $W - g(T)$.
]

Thus, valid squads of power $p$ correspond to cuts of capacity $W - p$. By the max-flow min-cut theorem, the set $S$ of vertices reachable from $s$ in the residual graph of a maximum flow is a minimum cut. It is finite (as $({s}, "rest")$ is a cut with weight $W < oo$), so by the claim the squad we return has power $W - "mincut"$ and no squad has more power as that would give a smaller cut. 

Heroes in $I$ are included, as they conflict with nobody and $g >= 0$.

*Running time.* If $E = emptyset$ we are done in $O(m+n)$, so assume $|E| >= 1$. Finding $I$ and building $N$ takes $O(m + n + |E|)$.

Every hero in $A' union B'$ is in at least one feud, so $|A'| + |B'| <= 2|E|$. Hence $N$ has $<= m + n + 2$ vertices and $<= |E| + |A'| + |B'| <= 3|E|$ edges. Edmonds-Karp runs in $O(|V||E|^2)$ so here it takes
$
O((m + n + 2) dot (3 |E|)^2) = O((m + n) |E|^2).
$
The BFS and the final assembly take $O(m + n + |E|)$. Hence the total is $O((m+n)|E|^2)$ (as $|E| >= 1$).

#remark[
  The reason for removing the isolated heroes is to make $|E_N| = O(|E|)$. If we did not, $|E_N|$ could be as large as $m + n$ which can be much more than $|E|$, and Edmonds-Karp would take $O((m+n)^3)$ instead of $O((m+n)|E|^2)$.
]

#prob[
  The kingdom of Dholakpur has $n >= 3$ villages connected by $m$ roads. Each road connects two different villages, and it is possible to travel between any pair of villages using the existing roads.

  We represent the kingdom as a connected, undirected graph $G=(V,E)$, where $|V|=n$ and $|E|=m$.

  With Diwali approaching, Raja Indravarma wants to reduce the kingdom's road maintenance expenses. He decides to keep exactly $n-1$ roads open and close all the remaining roads, while ensuring that every village remains reachable from every other village using the open roads. Thus, the open roads must form a spanning tree $T$ of $G$.

  Meanwhile, Bheem, Chutki, and Raju have been assigned the responsibility of storing the Diwali firecrackers safely. To prevent accidents and keep the firecrackers away from busy roads, they decide to store them only in villages that are connected to exactly one other village through the open roads.

  Such a village is called a leaf (or a dead end) of the spanning tree $T$.

  For each of the following problems, determine whether the required spanning tree exists. Either design a polynomial-time algorithm and prove its correctness, or prove that the problem is NP-complete.

  (a) Given $G$ and a set $F subset.eq V$, is there a spanning tree $T$ of $G$ in which every village in $F$ is a leaf? Villages not belonging to $F$ may also be leaves.

  (b) Given $G$ and a set $F subset.eq V$, is there a spanning tree $T$ of $G$ in which the set of leaves is exactly $F$?

  (c) Given $G$ and an integer $k$, is there a spanning tree $T$ of $G$ having at least $k$ leaves? 
]

(a) *Polynomial.* 

#claim[There is a spanning tree in which every vertex of $F$ is a leaf iff
+ $V without F != emptyset$, and $G[V without F]$ is connected, and
+ every $v in F$ has a neighbour in $V without F$.
]

#proof[
  ($arrow.l.double$) Take a spanning tree $T_0$ of $G[V without F]$ (exists by 1). For each $v in F$ add one edge from $v$ to a neighbour outside $F$ (exists by 2). This is a tree on $V$ in which each $v in F$ has degree $1$.

  ($arrow.r.double$) Let $T$ be such a tree. Since $n >= 3$, $T$ has a vertex which is not a leaf, so $V without F != emptyset$. If $v in F$ were adjacent in $T$ to another leaf $u$, then $T$ would be just the edge $u v$ (both being leaves), contradicting $n >= 3$. So the unique neighbour of $v$ in $T$ is in $V without F$, giving 2. Removing leaves from a tree leaves a tree (connected), so $T - F$ is a connected spanning subgraph of $G[V without F]$, giving 1.
]

*Algorithm:* Simply check the conditions: run BFS in $G[V without F]$ from any of its vertices and check it reaches all of $V without F$ and scan the adjacency list of each vertex in $F$. This is $O(n + m)$.

(b) *NP-complete.* The problem is in NP: the certificate is $T$; we check it is a spanning tree and compute its leaves in $O(n+m)$.

For hardness, reduce from Hamiltonian Path between $s$ and $t$: given $(G, s, t)$ output $(G, F = {s, t})$.

- If $G$ has a Hamiltonian path from $s$ to $t$, the path is a spanning tree and its leaves are exactly its two endpoints $s, t$.
- Conversely, if $T$ is a spanning tree with leaf set exactly ${s,t}$, then $T$ is a tree with exactly two leaves, which is a path (a tree with $>= 3$ vertices and max degree $>= 3$ has $>= 3$ leaves, so max degree is $2$, i.e. a path). It is spanning with endpoints $s$ and $t$: a Hamiltonian $s$-$t$ path.

The reduction is $O(1)$. #h(1fr) $square$

(c) *NP-complete.* It is in NP as above (certificate: $T$, count leaves).

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

#remark[
  Problem (c) is called the Maximum Leaf Spanning Tree problem. Though, it is NP-hard a linear-time algorithm can find a tree with at least half the optimal number of leaves (a 2-approximation). 
  
  It also becomes tractable when $k$ is a small constant (a fixed parameter tractable problem) with running time $O(3.72^k "poly"(n))$.

  Though, both of these are not known to be sharp.
]

#prob[
  Luffy and Zoro are sailing from island $1$ to island $n$. Each island $i$ in the sea is represented by a point $(x_i, y_i)$. The ship can only sail parallel to the axis.

  At every island, Luffy decides who helms the ship when it is sailing North-South and who helms the ship when it sailing East-West. The ship sails at $1$ unit an hour.

  Luffy wants to minimize the amount of time he spends on the helm. He doesn't particularly care about the route they end up taking.

  (a) Given the coordinates of all the $n$ islands, give an algorithm to figure out the route that minimizes time Luffy spends on the helm in $O(n log n)$ time.

  (b) Prove that your algorithm is correct, and that its running time is indeed $O(n log n)$.
]

#remark(title: "Source")[
  This ia a reskin of a problem from the 19th Polish Collegiate Programming Contest (2014), authored by Jakub Łącki. I found it, yet again in the pages of "Looking For a Challenge 2".
]

As, Luffy can only change who helms what at islands. Therefore, going from $p = (x_p, y_p)$ to $q = (x_q, y_q)$, the ship travels at least $|x_p - x_q|$ horizontally and at least $|y_p - y_q|$ vertically. Luffy helms one of them, so he spends at least $w(p, q) := min(|x_p - x_q|, |y_p - y_q|)$ hours on this leg, and this is achieved by sailing straight along the $L$-shaped path and letting Luffy helm the shorter side. 

So the answer is the shortest path from island $1$ to island $n$ in the complete graph with edge weights $w$.

Sadly, this does not solve our problem. The complete graph has $Theta(n^2)$ edges. Dijkstra over them would take $O(n^2 log n)$ time. What do we do? We only keep $O(n)$ of them.

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

(b) *Running time.* Sorting is $O(n log n)$. $H$ has $n$ vertices and $<= 2(n-1)$ edges. Dijkstra takes $O((m' + n) log n) = O(n log n)$. Total $O(n log n)$.

*Correctness.* Let $d_K$ be the distance in the complete graph $K$ (with weights $w$) and $d_H$ the distance in $H$. Since $H subset.eq K$ with the same weights, $d_H >= d_K$. We will show $d_H <= d_K$.

#claim[
  For any two islands $p, q$, $d_H (p,q) <= w(p,q)$.
]
#proof[
  Suppose $w(p,q) = |x_p - x_q|$, i.e. $|x_p - x_q| <= |y_p - y_q|$. 
  
  Let $p = r_0, r_1, dots, r_j = q$ be the islands between them in the sorted order $X$ (consecutive in $X$, ties in $x$ broken arbitrarily; the $x$-coordinates are monotone along this sequence). Each $r_i r_(i+1)$ is an edge of $H$ of weight $<= |x(r_i) - x(r_(i+1))|$. Summing, since the $x$-coordinates are monotone,
  $
  d_H (p,q) <= sum_i |x(r_i) - x(r_(i+1))| = |x_p - x_q| = w(p,q).
  $
]

Now take a shortest path in $K$ from $1$ to $n$. Replace each of its edges $p q$ by a path in $H$ of length $<= w(p,q)$. We get a walk in $H$ of length $<= d_K (1, n)$, so $d_H <= d_K$. Hence $d_H = d_K$, which is the answer. Dijkstra applies as the weights are non-negative. #h(1fr) $square$

#remark[

  Notice, the weights are not a metric. The edge weight $w(p,q) = min(|x_p - x_q|, |y_p - y_q|)$ does not satisfy the triangle inequality, so going directly doesn't work. 
  
  Take $p = (0,0)$, $r = (10, 0)$, $q = (10,10)$. Then $w(p, q) = 10$, but $w(p, r) = 0$ (Luffy lets Zoro take the east-west leg) and $w(r, q) = 0$ (Luffy lets Zoro take the north-south leg), so the route through $r$ costs $0$.

  Also, we 'sparsified' the graph. The idea that every "long jump" can be simulated by short hops between neighbors in the some order, without losing anything, is often how a lot of graph algorithms are created. In this case, it works because both $|x_p - x_q|$ and $min(dots)$ are bounded by the same telescoping sum along the sorted sequence. However, it would *not* work for the max of the two or for the sum. It's usually not very clear when it works or what order to use (although, it is worth keeping at the back of the mind).
]

#prob[
  To get Bheem into trouble with Raja Indravarma, Kalia and Dholu-Bholu have punched holes in $n$ water tanks of Dholakpur, numbered $1,dots,n$. Bheem repairs them one at a time. Repairing tank $i$ takes $t_i$ days, and from day $0$ tank $i$ leaks $s_i$ litres of water per day until its repair is finished

  Here $t_i$ and $s_i$ are positive integers. 
  
  Fuelled by Tun Tun Mausi’s laddoos, Bheem never stops a repair halfway and never rests between repairs.
  
  Formally, a schedule is an ordering $pi = (pi_1, pi_2, dots, pi_n)$ of the $n$ tanks. The repair of $π_j$ finishes at time $C_π_j = t_π_1 + dots + t_π_j$, so tank $i$ loses $s_i C_i$ litres, and the loss of $π$ is $L(π) = sum^n_(i=1) s_i C_i$. 
  
  A schedule is optimal if no schedule has a smaller loss. We want an optimal schedule.
  
  Example: For $t = [2,1,3]$ and $s = [1,3,2]$, the schedule $(1,2,3)$ loses $1 dot 2 + 3 dot 3 + 2 dot 6 = 23$ litres, while $(2,3,1)$ loses 3 dot 1 + 2 dot 4 + 1 dot 6 = 17 litres.
  
  (a) Give an algorithm `Schedule(t,s)`, in pseudocode, that returns an optimal schedule in $O(n log n)$ time.
  
  (b) Show that `Schedule` indeed runs in $O(n log n)$ time.

  (c) Prove that Schedule is correct.
]

(a) Sort the tanks by $t_i / s_i$ in non-decreasing order. This is called the 'Smith's rule'.

#psudo(title: "Schedule")[
+ def Schedule($t, s$):
  + $pi$ = $[1, 2, dots, n]$
  + sort $pi$ with comparator: $i prec j$ iff $t_i s_j < t_j s_i$ or ($t_i s_j = t_j s_i$ and $i < j$)
  + return $pi$
]

(b) The comparator is $O(1)$, so a merge sort takes $O(n log n)$.

(c) *Correctness.* Let $sigma$ be the order returned by Schedule. We say a pair of tanks $i, j$ is an *inversion* of a schedule $pi$ if $j prec i$ in the order above but $i$ appears before $j$ in $pi$.

*Exchange Argument* Let $i, j$ be adjacent in $pi$ with $i$ immediately before $j$, and let $P$ be the total time of the repairs before them. Exchanging them changes only the completion times of $i$ and $j$, and the loss of these two is
$
"i first:" & s_i (P + t_i) + s_j (P + t_i + t_j)\
"j first:" & s_j (P + t_j) + s_i (P + t_j + t_i)
$
The difference ($i$ first minus $j$ first) is $s_j t_i - s_i t_j$. So when $t_i / s_i >= t_j / s_j$, that is, when $t_i s_j >= t_j s_i$, putting $j$ first is no worse; and the loss is unchanged if the ratios are equal. All other tanks are untouched (their completion times are unchanged as $t_i + t_j$ is the same).

Thus, among all optimal schedules, pick $pi$ with the fewest inversions. Suppose it has an inversion. Then it has an *adjacent* inversion as $pi != sigma$, the there are adjacent positions $i, j$ with $j prec i$, otherwise $pi$ would be increasing in $prec$, so it equals $sigma$ since $prec$ is a total order.

Exchanging this adjacent pair places $j$ before $i$, that is in the right order, as $j prec i$ means $t_j s_i <= t_i s_j$. By the exchange argument, the loss does not increase, so the new schedule is also optimal, and it has exactly one inversion fewer. 

This contradicts the choice of $pi$. Thus, $pi$ has no inversions, so $pi = sigma$ and $sigma$ is optimal. #h(1fr) $square$

#prob[
  In TTRPGs, the notation `kDndlm` means rolling $k$ fair $n$ sided dice and dropping the lowest $m$. For example `4D6dl1` means rolling 4 six-sided dice and dropping the lowest. So if I rolled $6,3,1,5$ then I would drop the $1$ and return $6 + 3 + 5 = 14$.

  (a) Write the base case and recursion to compute `prob(k,n,m,x)` which is the probablity that rolling `kDndlm` gives the value $x$.

  (b) Argue the correctness of your recursion.

  (c) What is the time complexity of the DP which this recursion gives?
]

Let $[dot]$ be $1$ if the statement is true and $0$ otherwise.

(a) While there are quite a few ways to this, this is the one with the least bookkeeping. 

Let `prob(k,n,m,x)` be the probability that the sum of the $k - m$ highest dice among $k$ rolls of an $n$-sided die is $x$.

The idea is to look at how many dice show the maximum value $n$, say $j$ of them. This happens with probability $binom(k, j) (1/n)^j ((n-1)/n)^(k-j)$. Conditioned on this, the remaining $k - j$ dice are independent and uniform on ${1, dots, n-1}$.

We sum over the values for $j$.

*Base cases:*
- If $x < 0$: `prob(k,n,m,x)` $= 0$
- If $m >= k$ (everything is dropped): `prob(k,n,m,x)` $= [x = 0]$.
- If $n = 1$ and $m < k$ (all dice show $1$): `prob(k,n,m,x)` $= [x = k - m]$.

*Recursion* ($m < k$, $n >= 2$):
$
"prob"(k,n,m,x) = sum_(j=0)^(k) binom(k,j) (1/n)^j ((n-1)/n)^(k-j) dot cases(
  [x = (k-m) n] & "if" j >= k - m,
  "prob"(k - j, n - 1, m, x - j n) & "if" j < k - m
)
$

(b) *Correctness.* Given $j$, the dice not showing $n$ are iid uniform on $[1, n-1]$ (conditioning on a die being not $n$ makes it uniform on the rest).
- If $j >= k - m$, there are at least $k - m$ dice showing the maximum value $n$. The $m$ lowest dice dropped can be taken as all the non-$n$ dice and some of the $n$'s; the dice kept are $k - m$ copies of $n$, so the sum is exactly $(k - m) n$
- If $j < k - m$, then all the $j$ copies of $n$ are among the kept dice (they are the highest, and there are fewer than $k - m$ of them). The remaining $k - m - j$ kept dice are the highest $k - m - j$ of the remaining $k - j$ dice, i.e. we drop the lowest $(k - j) - (k - m - j) = m$ of them. This is exactly `(k-j)D(n-1)dl m`.

The cases partition the sample space by $j$ so the probabilities add up. The recursion terminates as in every recursive call $n$ strictly decreases (and $k$ does not increase), so we end at the base cases eventually.

(c) *Complexity.* Note that $m$ never changes in the recursion. The states are $(k', n', x')$ with $k' <= k$, $n' <= n$ and $0 <= x' <= k' n'$. That is $sum_(k' <= k) sum_(n' <= n) k' n' = O(k^2 n^2)$ states. Each state does a sum over $j in [0, k']$, so $O(k')$ work each (assuming arithmetic is $O(1)$ and the binomials $binom(k', j)$ and the powers of $1/n'$ and $(n'-1)/n'$ are precomputed in $O(k^2 + k n)$ time). In total
$
sum_(k' <= k) sum_(n' <= n) k'^2 n' = O(k^3 n^2).
$
So the DP runs in $O(k^3 n^2)$ time (and $O(k^2 n^2)$ memory).

#remark[
*Other recursions.* There are other natural ways to set this up. You can condition on the *lowest* value instead (how many dice show $1$), which is the mirror image: those are exactly the first dice to be dropped, and you remove $m$ minus (number of ones) from the drop count, and shift all the remaining dice down by one. Or you can sort the dice and think of the order statistics (number of 1s, number of 2s etc). Both of these run in $O(k^3 n^2)$.

There is another answer that runs in $O(c^2 n^2)$ where $c = k - m$. The idea is to let $t$ be the value of the $c$-th largest die, and let $a$ be the number of dice strictly above $t$. We can now write
$
#text[`prob`] (k, n, m ,x) = sum_(t = 1)^n sum_(a = 0)^(c-1) binom(k, a) n^(-a) R(t,a) #text[`prob`] (a, n - t, 0 ,x - c t)
$

where $R(t, a)$ is the probability that, among the other $k−a$ dice, at least $c−a$ show exactly $t$ and the rest show less than $t$. Calculating $R$ would take some $O(c^2 n)$ time naively.

Notice, if we don't have to drop anything, calculating `prob`$(dot, dot, 0, dot)$ is much simpler and can be done in $O(c^2 n^2)$ time.

Thus, we have a $O(c^2 n^2)$ algorithm.

Some FFT trickery from here + an interesting divide and conquer idea can get us to an $tilde(O)(c n^2 + c^2 n)$ algorithm as well (here $tilde(O)$ denotes that poly-log factors have been suppressed) (but that is overkill + the constants make it very much a non practical).
]

#prob[
  The clock-it club has the rules that:
  - everyone must clock themselves
  - if someone clocks you, you must clock them
  - if someone you clocked, clocks someone else; you must also clock them.

  The club has $n$ members and $m$ sub-clubs. We call a set of people a 'sub-club' if all of them clock each other but they don't clock anyone outside it.

  (a) Design an algorithm to count in how many different ways is this possible in $O(n m)$ time. 
  
  (b) Design an algorithm to count in how many different ways is this possible modulo $998244353$ in $O(m log n)$ time.

  (c) Say we don't know the value of $m$ and would like the know the number of ways this is possible for any given value of $1 <= m <= n$. Design an algorithm to compute this modulo $998244353$ in $O(n log n)$ time.
]

#remark(title: "Source")[
  Inspired by CMI's very own Clock It Club. I had joked that if the club gets going, I'll make a problem on it and this is what I came up with. 
  
  I also had something along the lines where you had to count the number of ways $n$ people could make a total of $m$ clocks (inspired by the 'hardest' problem on JEE Adv 2026; it was not that hard, people just don't teach math well at coaching level and this being a little non-standard screwed most of the kids. Their question was $n = 10$ and $m = 42$, you'll probably solve it in a jiffy). But doing it very fast ($O(n log n + m log m)$) needs a bit more interesting ideas (Newton iteration and exponential generating functions) that Prof. Samir wouldn't allow me to put, so that was shelved and instead this one, which is a bit easier, was given.
]

The rules say that "clocks" is a relation on people which is
- reflexive (everyone clocks themselves),
- symmetric (if someone clocks you, you clock them),
- transitive (if you clock $b$ and $b$ clocks $c$, you clock $c$).

That is exactly an *equivalence relation* and the sub-clubs are exactly its equivalence classes. 

So the number of ways to have exactly $m$ sub-clubs is the number of partitions of $n$ people into $m$ non-empty (unlabelled) sets, which is the Stirling number of the second kind $S(n, m)$.

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
S(n, m) = 1/(m!) sum_(i=0)^m (-1)^(m-i) binom(m, i) i^n
$

*Time Complexity:* Computing the factorials is $O(m)$, the one inverse is $O(log p) = O(1)$ (by Fermat's Little Theorem), and each of the $m + 1$ values of $i^n$ is computed by repeated squaring in $O(log n)$.

Thus, a total of $O(m log n)$ time is used.

(c) We want $S(n, m)$ for all $0 <= m <= n$. Notice,
$
S(n, m) = 1/(m!) sum_(i=0)^m (-1)^(m-i) binom(m, i) i^n\ 
= sum_(i=0)^m 1/m! (-1)^(m-i) m!/((m-i)! i!) dot i^n \
= sum_(i=0)^m (i^n / i!) dot ((-1)^(m-i) / (m-i)!)
$

Thus, the last form of the formula is a convolution. Let
$
a_i = i^n / i!, quad b_k = (-1)^k / k!, quad "then" quad S(n, m) = sum_(i=0)^m a_i b_(m-i) = (a * b)_m.
$

#psudo(title: "All Stirling Numbers of Fixed n")[
+ def all_counts($n$):
  + compute $"fact"[0..n]$ and $"inv"[0..n]$ as before ($n < 2^23 < p$ so all are invertible)
  + $a[i] = "power"(i, n) dot "inv"[i]$ for $i = 0..n$
  + $b[k] = (-1)^k dot "inv"[k]$ for $k = 0..n$
  + $c$ = CONVOLVE($a, b$)
  + return $c[1..n]$ 
]

*Time:* $O(n)$ for the factorials and inverses, $n + 1$ fast exponentiations for a total of $O(n log n)$, and one CONVOLVE of two arrays of size $n + 1$ which costs $O(n log n)$. Thus, a total of $O(n log n)$. 

#remark[
  The hint about $998244353 = 1 + 7 dot 17 dot 2^23$ is the reason `CONVOLVE` (a number theoretic transform, which is the FFT done in $ZZ_p$ instead of over the complex numbers) works mod this prime for sizes up to $2^23$: you need a $2^k$-th root of unity $omega$ for the transform of size $2^k$, and in $ZZ_p$ these exist exactly when $2^k | p - 1$. Here we get to use it as a black box, which is the whole point of the question: spot that the inclusion-exclusion formula is a convolution. 
  
  Had this prime not been given, you could still do the convolution over the integers with a slower or approximate method but that is beyond this course.
]