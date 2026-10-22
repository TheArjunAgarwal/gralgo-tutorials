#import "../style.typ": *



#show: main.with(
  title: [Graduate Algorithms],
  subtitle: [Basic problems on Flows],
  date: datetime.today()
)

#quote(attribution: "@flugenof, Twitter")[
the problem with AI isn't that just that it's ugly and lazy, it's indicative of a culture uncaring about everything. you have to care about something. you have to care about what you're putting out in the world. you have to make effort somewhere so people can perceive it.
]

This problem set mostly asks you to prove some of the lemmas and theorems related to Min-Cut Max-Flow, the time complexity of the algorithms and then some basic modifications.

We will have another problem set on the applications of flow.

= Min-Cut and Max-Flow Duality
#defn[
A flow network is a directed graph $G = (V, E)$ where each edge has a nonnegative capacity. We formalize this by saying there is a map $c: E -> RR_(>=0)$. 

Furthermore, $G$ is such that $(u,v) in E => (v,u) in.not E$
]

#defn[
  Let two different vertices $s,t in V$ be given; call them the source and sink, respectively. A flow is a map $f : E -> RR_(>=0)$, satisfying:

  - Edge rule: for every edge $e$, $0 <= f(e) <= c(e)$ aka the flow on every edge is nonnegative and no larger than the capacity of the edge.
  - Vertex rule: For every vertex $v$ other than $s, t$ $
  sum_(x in N_"in"(v)) f(x,v) = sum_(x in N_"out"(v)) f(v,x)
  $
  that is the sum of the flows on incoming edges is equal to the sum of the flows on outgoing edges.
]
Some example of valid flows where $x slash y$ means a flow of $x$ on an edge of capacity $y$.
#figure(image("example.png"))

Some examples of invalid flows:
#figure(image("anti-example.png"))

#defn[
  We define the value of flow as:
$
|f| = sum_(x in N_"out"(s)) f(s,x) - sum_(x in N_"in"(s)) f(x,s)
$
]

#defn[
  An $s-t$ cut is a partition $V = S union T$ where $S$ and $T$ are disjoint and $s in S$, $t in T$, and the cost of an $s-t$ cut is
  $
  c(S, T) = sum_(x in S, y in T, (x,y) in E) c(x,y)
  $
]



#exercise[
  Prove that for any flow $f$ and any $s-t$ cut $(S, T)$ of $G$, we have $|f| <= c(S, T)$. 
  
  In particular, we want to show that the value of the max flow is at most the value of the min cut.
]

#exercise[
  Prove that if we can find $f$ and $(S, T)$ such that $|f| = c(S, T)$, then $f$ is a max flow and $(S, T)$ is a min $s-t$ cut.
]
#defn[
We define a residual graph $G_f$ where the residual capacities $c_f : V times V -> RR_(>=0)$ are defined as follows:
$
c_f (u, v) = cases(c(u, v) − f (u, v) quad &"if" (u, v) in E,
f (v, u) quad &"if" (v, u) in E,
0 quad &"otherwise")
$

Basically, what this does is that, if there is any flow through the edge, you remove the flow
from the capacity and add an edge in the opposite direction with the value of the flow.
]

#exercise[
  Show that if $t$ is not reachable from $s$ is $G_f$, then $f$ is a maximum flow.
]

#exercise[
  Show that if $G_f$ has a path from $s$ to $t$, we can modify $f$ to $f′$ such that $|f| < |f'|$

  *Hint*: Consider if there is a simple path $P$ in $G_f$ such that $s = x_0 -> x_1 -> dots -> x_k = t$, and let $F = min c_f (x_i, x_(i+1))$. We define a new flow $f'$ where:
$
f'(u,v) = cases(
  f(u,v) + F quad &"if" (u,v) in P,
  f(u,v) - F quad &"if" (v,u) in P,
  f(u,v) quad &"otherwise"
)
$
]

#exercise[
  Can you use the above exercises to create an algorithm that finds the maximum flow?

  Also, can you use this to conclude that min-cut and max-flow are equivalent?
]

= Time Complexity of Max-Flow
#exercise(title: "Max-Flow Algorithm")[
  Show that this algorithm runs in $O(|f|m)$ time:
  #psudo(title: "Max-Flow Algorithm")[
    + $f <-$ all zeroes flow
    + $G_f <- G$
    + while $t$ is reachable from $s$ in $G_f$ (check using, DFS or BFS etc):
      + $P <-$ path in $G_f$ from $s$ to $t$
      + $F$ ← min capacity on $P$
      + $f' <- f$ as defined above
      + Update $G_f$ to correspond to new flow
    + return $f$
  ]

  Note we call the chosen path $P$ the augmenting path and the update $f'$ as the augmentation.
]

#exercise(title: "Ford-Fulkerson Algorithm")[
  Say we have a black box algorithm that given a graph $G$ finds a path between vertices $s$ and $t$ such that maximizes $min_(e in P) c_f (e)$ among all $s-t$ paths $P$ in in O(m + n) time.#footnote[This is indeed possible by a clever mix of median finding + DFS].

  The Ford-Fulkerson Algorithm uses the above blackbox to choose the augmenting path.

  Show that for graph with integer capacities, the Ford-Fulkerson algorithm runs in\ $O((m + n)m log|f|)$ time.

  *Hint*: You might want to first show that if we let $f'$ be the max flow in $G_f$. Then after one iteration of Ford-Fulkerson on $G_f$, the max flow on $G_f$ becomes ≤ $|f′|(1 − 1/m)$

  *Hint:* Does our choice of augmenting path $P$ give us a way to cut $G_f$ (consider what the minimum capacity edge is..)? What can be said about the value of flow? Perhaps using the min-cut max-flow duality...
]

#exercise(title: "Edmonds-Karp algorithm")[
  In this algorithm, we choose the augmenting path between $s$ and $t$ using BFS, thus picking a path that minimizes the number of edges. 
  
  Note, this runs in $O(n + m) = O(m)$ time as we only check the connected component of $s$ and in connected graphs, $m >= n - 1$.

  Show that this Edmonds-Karp algorithm runs in $O(n m^2)$.

  *Hint:* You might first want to show for any $u,v in V$ such that $(u,v)$ is an edge in $G_f$ at some point, then the number of times that the edge $(u, v)$ can disappear from $G_f$ is at most $n/2$.

  *Hint:* Let $G^i_f$ be the residual network after the $i$-th iteration of the algorithm; $G^0_f = G$. For a vertex $v$ , let $d_i (v)$ be the (unweighted) distance from $s$ to $v$ in $G^i_f$. Now show that for all $i >= 1$, and all $v in V , d_(i-1) (v) <= d_i (v)$.

  *Hint:* For the above, induct on the distance from $s$!
]

= Variations on Min-Cut Max-Flow
For all the below, assume we can find the min-cut or max-flow in $O(n m^2)$ time.

#exercise(title: "Verification")[
  Given $G$ and $f$ , design an $O(n+m)$ time algorithm to determine if the flow $f$ is a maximum flow in $G$.
]

#exercise(title: "Flow Update I")[
  Suppose that the capacity of a single edge $e in E$ is increased by $1$. Given $G$, its maximum flow $f$ before the update and the edge to be updated $e$, design an $O(n + m)$ time algorithm to find a new maximum flow $f'$.
]

#exercise(title: "Flow Update II")[
  Suppose that the capacity of a single edge $e in E$ is decreased by $1$. Given $G$, its maximum flow $f$ before the update and the edge to update $e$, design an $O(m+n)$ time algorithm to find a new maximum flow $f'$.
]

#exercise(title:"Loops")[
  Our graph $G$ had the condition $(u,v) in E => (v,u) in.not E$. Can you give an algorithm to find the max flow in $O(m^2 (m+n))$ time?
]

#exercise(title: "Max Flow with Parallel Edges")[
  Suppose $G$ is allowed to have multiple directed edges
  from $u$ to $v$, possibly with different capacities. Can you give an algorithm to find a maximum flow in $O(n m^2)$ time?
]

#exercise(title : "Multiple Sources and Sinks")[
  Suppose the graph has sources $s_1, ..., s_k$ and
  sinks $t_1, ..., t_r$. Flow may originate at any source
  and terminate at any sink. Reduce this problem to a
  standard single-source, single-sink max-flow problem.
]

#exercise(title: "Max Flow with Vertex Capacities")[
  Suppose every vertex $v$ (except the source $s$ and
  sink $t$) has a capacity $c(v)$, limiting the total
  amount of flow that can pass through it.

  Find the max flow in $O((m+n)^2 n)$ time.
]

#exercise(title: "Minimum Number of Edges in a Cut")[
  Find an $s$-$t$ cut that contains the minimum possible
  number of edges, regardless of their capacities.
  Can this problem be reduced to an ordinary min-cut
  problem? Give a reduction and prove its correctness.
]

#exercise(title: "A Cut with a Prescribed Vertex")[
  Given a vertex $v$, find a minimum $s$-$t$ cut such
  that $v$ belongs to the same side as $s$.
  Give an algorithm that runs in $O(m^2 n)$ time.
]