#import "../style.typ": *

#show: main.with(
  title: [Graduate Algorithms],
  subtitle: [What Your Endsem Could Look Like...],
  date: datetime.today(),
  report-style : false
)

#quote(attribution: [Brennan Lee Mulligan & Lee Ostertag, Strong Female Protagonist])[
Nobody in the whole world is normal. That's an idea made up by clothing companies to sell t-shirts. It doesn't exist in nature. Everybody gets to be weird in their own special way.
]

THIS IS NOT A MOCK! THIS IS NOT A PREDICTION! IF ANYTHING, IT IS FOR PREPARATION PURPOSE ONLY.

 This exam has *7 questions* for a *total of 800 marks*, of which you can score *at most 400 marks*. You may answer any subset of questions or parts of questions. All answers will be evaluated. Go through all the questions once before you start writing your answers.
 
 You may use the following functions, and assume in your analysis that they work correctly with the stated worst-case running times:
- `LENGTH(A)`: returns the length $n$ of array $A$, and runs in $O(n)$ time
- `MERGESORT(A)`: returns the version of integer array $A$ which is sorted in non-decreasing order, and runs in $O(n log n)$ time when $A$ has $n$ elements
- `BINARYSEARCH(A, v)`: returns the index of integer element $v$ in a sorted array $A$, or `NIL` if $v$ is not present in $A$. Runs in $O(log n)$ time when $A$ has $n$ elements
- `BFS(G, s)` and `DFS(G, s)`: return the set of vertices reachable from $s$ (and a BFS/DFS tree) in a graph $G$ with $n$ vertices and $m$ edges, in $O(n + m)$ time
- `DIJKSTRA(G, s, t)`: returns the shortest distance between $s$ and $t$ in a weighted (directed) graph $G$ with non-negative weights, in $O((m + n) log n)$ time where $G$ has $n$ vertices and $m$ edges
- `EDMONDSKARP(G, s, t, c)`: returns a maximum $s$-$t$ flow, and its residual graph, in a flow network $G$ with capacities $c$, in $O(|V||E|^2)$ time
- `KRUSKAL(G, w)`: returns a minimum spanning tree of a connected weighted undirected graph $G$ in $O(m log n)$ time
- `CONVOLVE(A, B)`: given coefficient arrays of two polynomials, returns the coefficient array of their product modulo $998244353$, in $O((|A| + |B|) log (|A| + |B|))$ time

You may also use, without proof, the following facts: the Max-Flow Min-Cut theorem, Konig's Theorem, the Time Hierarchy Theorem, the Cook-Levin theorem and the NP-completeness of each of the following problems (as the source of a reduction): 3-SAT, Independent Set, Clique, Vertex Cover, Hamiltonian Path (between two specified vertices $s$ and $t$), Dominating Set, 3-Colouring, Subset Sum and Travelling Salesman (decision version).
  
You may freely invoke functions that you have written as part of a different answer in the same answer sheet.

Unstated assumptions and lack of clarity in solutions can and will be used against you during evaluation. You may freely refer to statements from the lectures in your arguments. You don't need to reprove these unless the question explicitly asks you to, but you must be precise.

#pagebreak()



+ Prof. Wuependra Wulkarni recently learned that we can compute $f^n (x)$ in $O(log n)$ calls to the function for some functions. This would provide an exponential speed up over the brute force $O(n)$ applications. 

  Wulkarni conjectures that this can be done to every function.

  (a) Prove that if Wulkarni's conjucture holds then $"P" = "NP"$ #h(1fr) *(40 Marks)*

  (b) Give an argument to show that Wulkarni's conjecture doesn't hold. #h(1fr) *(60 Marks)*

  *Note:* You may not use $"P" != "NP"$ for this part (b) as we don't know that to be true. That said, if you can prove it, feel free to use it. You will receive full credit (although, I suppose that won't be a concern then).

  *Hint:* The model solution uses $P subset.neq "EXP"$ aka Time Hierarchy Theorem (we don't expect a proof of THT) but there are loads of other (simpler) answers that also work.

+ Doom is coming, and Nick Fury is putting together a strike team from two groups of heroes: the Avengers and the X-Men. There are $m$ Avengers, forming a set $A$, and $n$ X-Men, forming a set $B$. Nobody belongs to both groups.

  Fury knows the power level $g(h) in ZZ_(>=0)$ of every hero $h$, and he wants the team with the largest possible total power. 

  However, the team has to function in battle, so no two members may be feuding. The relationships between heroes are as follows:

  - Any two Avengers get along, and any two X-Men get along.
  - Some Avenger-X-Men pairs do *not* get along. These feuds are given as a set $E subset.eq A times B$, where $(a, b) in E$ means that $a$ and $b$ are feuding (this is mutual).
  - All other Avenger-X-men pairs get along.

  A set $T subset.eq A union B$ is a *valid squad* if it contains no feuding pair, i.e. there is no $(a, b) in E$ with $c,d in T$. Its *power* is $sum_(h in T) g(h)$.

  (a) Write a program `bestSquad(C, D, E, g)` that returns a valid squad of maximum power. Your algorithm must run in $O((m+n)|E|^2)$ time. #h(1fr) *(70 Marks)*

  (b) Prove that your algorithm is correct, and that its running time is indeed $O((m+n)|E|^2)$.
  
  #h(1fr) *(50 Marks)*

  *Hint*: The complexity seems awfully reminiscent of Edmond-Karp's

+ The kingdom of Dholakpur has $n >= 3$ villages connected by $m$ roads. Each road connects two different villages, and it is possible to travel between any pair of villages using the existing roads.

  We represent the kingdom as a connected, undirected graph $G=(V,E)$, where $|V|=n$ and $|E|=m$.

  With Diwali approaching, Raja Indravarma wants to reduce the kingdom's road maintenance expenses. He decides to keep exactly $n-1$ roads open and close all the remaining roads, while ensuring that every village remains reachable from every other village using the open roads. Thus, the open roads must form a spanning tree $T$ of $G$.

  Meanwhile, Bheem, Chutki, and Raju have been assigned the responsibility of storing the Diwali firecrackers safely. To prevent accidents and keep the firecrackers away from busy roads, they decide to store them only in villages that are connected to exactly one other village through the open roads.

  Such a village is called a leaf (or a dead end) of the spanning tree $T$.

  For each of the following problems, determine whether the required spanning tree exists. Either design a polynomial-time algorithm and prove its correctness, or prove that the problem is NP-complete.

  (a) Given $G$ and a set $F subset.eq V$, is there a spanning tree $T$ of $G$ in which every village in $F$ is a leaf? Villages not belonging to $F$ may also be leaves. #h(1fr) *(40 Marks)*

  (b) Given $G$ and a set $F subset.eq V$, is there a spanning tree $T$ of $G$ in which the set of leaves is exactly $F$? #h(1fr) *(40 Marks)*

  (c) Given $G$ and an integer $k$, is there a spanning tree $T$ of $G$ having at least $k$ leaves? 
  
  #h(1fr) *(40 Marks)*

+ Luffy and Zoro are sailing from island $1$ to island $n$. Each island $i$ in the sea is represented by a point $(x_i, y_i)$. The ship can only sail parallel to the axis.

  At every island, Luffy decides who helms the ship when it is sailing North-South and who helms the ship when it sailing East-West. The ship sails at $1$ unit an hour.

  Luffy wants to minimize the amount of time he spends on the helm. He doesn't particularly care about the route they end up taking.

  (a) Given the coordinates of all the $n$ islands, give an algorithm to figure out the route that minimizes time Luffy spends on the helm in $O(n log n)$ time. #h(1fr) *(80 Marks)*

  (b) Prove that your algorithm is correct, and that its running time is indeed $O(n log n)$. 
  
  #h(1fr) *(40 Marks)*

  *Hint:* Other than sorting, $O(n log n)$ is the time complexity of something else as well... perhaps, calling it $O(V log V)$ might help a bit more. 

+ To get Bheem into trouble with Raja Indravarma, Kalia and Dholu-Bholu have punched holes in $n$ water tanks of Dholakpur, numbered $1,dots,n$. Bheem repairs them one at a time. Repairing tank $i$ takes $t_i$ days, and from day $0$ tank $i$ leaks $s_i$ litres of water per day until its repair is finished

  Here $t_i$ and $s_i$ are positive integers. 
  
  Fuelled by Tun Tun Mausi’s laddoos, Bheem never stops a repair halfway and never rests between repairs.
  
  Formally, a schedule is an ordering $pi = (pi_1, pi_2, dots, pi_n)$ of the $n$ tanks. The repair of $π_j$ finishes at time $C_π_j = t_π_1 + dots + t_π_j$, so tank $i$ loses $s_i C_i$ litres, and the loss of $π$ is $L(π) = sum^n_(i=1) s_i C_i$. 
  
  A schedule is optimal if no schedule has a smaller loss. We want an optimal schedule.
  
  Example: For $t = [2,1,3]$ and $s = [1,3,2]$, the schedule $(1,2,3)$ loses $1 dot 2 + 3 dot 3 + 2 dot 6 = 23$ litres, while $(2,3,1)$ loses 3 dot 1 + 2 dot 4 + 1 dot 6 = 17 litres.
  
  (a) Give an algorithm `Schedule(t,s)`, in pseudocode, that returns an optimal schedule in $O(n log n)$ time. #h(1fr) *(20 Marks)*
  
  (b) Show that `Schedule` indeed runs in $O(n log n)$ time. #h(1fr) *(10 Marks)*

  (c) Prove that Schedule is correct. #h(1fr) *(50 Marks)*

+ In TTRPGs, the notation `kDndlm` means rolling $k$ fair $n$ sided dice and dropping the lowest $m$. For example `4D6dl1` means rolling 4 six-sided dice and dropping the lowest. So if I rolled $6,3,1,5$ then I would drop the $1$ and return $6 + 3 + 5 = 14$.

  (a) Write the base case and recursion to compute `prob(k,n,m,x)` which is the probablity that rolling `kDndlm` gives the value $x$. #h(1fr) *(40 Marks)*

  (b) Argue the correctness of your recursion. #h(1fr) *(25 Marks)*

  (c) What is the time complexity of the DP which this recursion gives? #h(1fr) *(15 Marks)*

+ The clock-it club has the rules that:
  - everyone must clock themselves
  - if someone clocks you, you must clock them
  - if someone you clocked, clocks someone else; you must also clock them.

  The club has $n$ members and $m$ sub-clubs. We call a set of people a 'sub-club' if all of them clock each other but they don't clock anyone outside it.

  (a) Design an algorithm to count in how many different ways is this possible in $O(n m)$ time. 
  
  #h(1fr) *(40 Marks)*
  
  (b) Design an algorithm to count in how many different ways is this possible modulo $998244353$ in $O(m log n)$ time. #h(1fr) *(60 Marks)*

  *Note*: Let $m, n < 998244353$. Also, $998244353$ is prime.

  *Hint*: Clubs, sub-clubs etc often cause some inclusion and exclusion among people. Just saying...

  (c) Say we don't know the value of $m$ and would like the know the number of ways this is possible for any given value of $1 <= m <= n$. Design an algorithm to compute this modulo $998244353$ in $O(n log n)$ time. #h(1fr) *(80 Marks)*
  
  *Note:* Let $n < 2^23$ and $m < 998244353$.

  *Hint*: Alongside being prime, $p = 998244353 = 1 + 7 dot 17 dot 2^23$. This just makes it so that there exists $omega$ such that $omega^k equiv -1 mod p$ is well behaved for $k < 2^23$. Why would that matter? Who knows...