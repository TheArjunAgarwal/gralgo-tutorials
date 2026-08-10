#import "../style.typ": *

#show: main.with(
  title: [Graduate Algorithms],
  subtitle: [Tutorial 1: Math for Algorithms],
  date: datetime.today()
)

= Introduction
There are two undeniably true things about the human experience: one, we are absolutely surrounded by problems, and two, our time on this weird, spinning space rock is far too limited to spend forever trying to solve them.

This is the entire motivation for the study of algorithms.

Long before computers existed, people were developing algorithms for arithmetic, navigation, voting, logistics, trade and everything in between. Computers simply gave us the ability to apply those ideas at scales that would otherwise be impossible.

In this course, we'll study how to think about problems in a way that allows us to solve them efficiently. We'll ask questions like:

- How do we compare different solutions?
- What makes one algorithm faster than another?
- How do we model complicated real-world situations?
- When is a problem easy, and when is it fundamentally difficult?
- And how do we deal with these 'difficult' problems?

So welcome to Graduate Algorithms.

After all, the world is full of problems. Might as well get good at solving them.

= Asymptotics
#definition(title: "Asymptotic Dominance")[
 Asymptotic Dominance is a relation over functions, where $f(n) prec g(n)$ when $g(n)$ approaches infinity faster than $f(n)$. We can formalize this by saying:
$
f(n) prec g(n) <==> limsup_(n -> oo) (|f(n)|)/(|g(n)|) = 0
$
Furthermore, $f(n) asymp g(n) <==> limsup_(n -> oo) (|f(n)|)/(|g(n)|) = k$ where $0 < k < oo$ is constent.
]

Some observations are:

#cor[
Asymptotic dominance is transitive.
]

#cor[
If $alpha < beta$ then $x^(alpha) prec x^(beta)$
]

#cor[
  Let $f(x) = k * g(x)$ for some real $k != 0$, then $f(x) asymp g(x)$
]

This previous observations tells us that the equivalence induced by asymptotic dominance is invariant under scaling and translation by dominated functions. 

That is, in a sum of functions, we only need to consider the most dominant function when comparing asymptotic dominence. This allows us to talk about a group of functions using a single 'representative' function.

#definition(title: "Representee Function wrt asymptotic dominance")[
The representative function of a set of asymptotically equivalent functions is the simplest form of the equivalence class, defined as:

- A function with a leading coefficient of $1$,
- No additive subdominant terms (i.e., no terms in addition that are asymptotically dominated by others in the class).
]
For example $x^2$ is the representative function of the equivalence class of quadratic functions, $a x^2 + b x + c$.

#thm[
  If $f(x),g(x)$ are the representative functions of the equivalence class $F,G$; then show that $f(x) succ g(x) <==> hat(f)(x) succ hat(g)(x)$ for all $hat(f) in F$ and $hat(g) in G$
  ]
#proof[
  ($==>$) Using the fact $f, hat(f) in F$, we get $f(x) asymp hat(f)(x) <==> lim_(x -> oo) (f(x))/(hat(f)(x)) = c_1$ where $c_1 != 0$ is a constant.

  Similarly, $g(x) asymp hat(g)(x) <==> lim_(x -> oo) (g(x))/(hat(g)(x)) = c_2$ where $c_2 != 0$ is a constant.

  Using $f(x) succ g(x) <==> lim_(x -> oo) (g(x))/(f(x)) = 0$

  Thus, 
  $
  limsup_(x -> oo) (|hat(g)(x)|)/(|hat(f)(x)|)\
  = limsup_(x -> oo) (|hat(g)(x)|)/(|g(x)|) dot (|g(x)|)/(|f(x)|) dot (|f(x)|)/(|hat(f)(x)|) \
  = 1/(c_2) dot 0 dot c_1 \
  = 0\
  => hat(f)(x) succ hat(g)(x)
  $

  ($<==$) $f in F$ and $g in g$ implies $f(x) succ g(x)$ as this is true for all functions in the equivalence classes.#footnote[We could just say this part was trivial.]
]

#exercise(title: "An Hieraarchy of Common Functions")[
  Prove that:
  $
  1 prec log(log(n)) prec log(n) prec n^(epsilon) prec n^c prec n^(log(n)) prec c^n prec n! prec n^n prec c^(c^n)
  $
]

== Big Oh notation

#definition(title: "Big Oh (from hierarchy)")[
  $f(n) = O(g(n)) <==> f(n) prec.eq g(n)$
]

#definition(title: "Big Oh (limit)")[
  $f(n) = O(g(n)) <==> limsup_(n -> oo) (|f(n)|)/(|g(n)|) < oo$.
]

We also give the classical definition.
#definition(title: "Big Oh (Classical)")[
  $f(n) = O(g(n)) <==> exists c, n_0 op("s.t.") forall n >= n_0, |f(n)| <= c dot |g(n)|$
  ]

While we have used $limsup$ here, it is only to deal with the cases where the limit is not guaranteed to exist. We can use $lim$ in place for all the definitions till here in most cases we will be concerned with.

In the family of big oh, we also have some more notations one must be aware of. This is called the Bachmann–Landau family, with contributions from Hardy and Knuth.
#definition(title: "Bachman-Landau Notation")[
  #table(columns: 4, 
  [Notation], [Name], [Classical Definition], [Limit Definition],
  [$f(n) = Theta(g(n))$], [Big Theta], [$exists k_1, k_2, n op(s.t.) forall n > n_0, k_1 g(n) <= |f(n)| <= k_2 g(n)$], [$
  f(n) asymp g(n)
  $],
  [$f(n) = Omega(g(n))$], [Big Omega], [$exists k, n_0 op(s.t.) forall n >= n_0, |f(n)| >= k g(n)$], [$
  liminf_(n -> oo) (|f(n)|)/(g(n)) = 0
  $],
  [$f(n) tilde g(n)$],[Total Asymptotic Equivalence (different for asymptotic equivalence defined using $asymp$.)],[],[$
  lim_(n -> oo) (f(n))/(g(n)) = 1
  $],
  [$f(n) = o (g(n))$], [Small Oh], [$exists k, n_0 op(s.t.) forall n >= n_0, f(n) <= k g(n)$], [$
  lim_(n -> oo) (f(n))/(g(n)) = 0
  $],
  [$f(n) = omega(g(n))$], [Small Omega], [$exists k, n_0 op(s.t.) forall n >= n_0, f(n) > k g(n)$], [$
  lim_(n -> oo) (f(n))/(g(n)) = oo
  $]
  )
]

Here is an example to illustrate the difference between the notations.

  - $3n^2 − 100n + 6 = O(n^2)$, because I choose $c = 3, n_0 = 6/100$;
  - $3n^2 − 100n + 6 = O(n^3)$, because I choose $c = 1, n_0 = 7/100$;
  - $3n^2 − 100n + 6 != O(n)$, because for any $c$ I can take $n > 100+ c$;
  - $3n^2 − 100n + 6 = Omega(n^2)$, because I choose $c = 2, n_0 = 100$;
  - $3n^2 − 100n + 6 != Omega(n^3)$, because for an $c$, I can take $n > 100/c$, if $c <1$ and $n > c$ otherwise;
  - $3n^2 − 100n + 6 = Omega(n)$, because for any $c$, I can take $n_0 = 100 c$;
  - $3n^2 − 100n + 6 = Theta(n^2)$, because both $O$ and $Omega$ apply;
  - $3n^2 − 100n + 6 != Theta(n^3)$, because $Omega$ fails;
  - $3n^2 − 100n + 6 != Theta(n)$, because $O$ fails.

Also note, $3n^2 - 100n + 6 tilde 3n^2$ by taking the limit.

Finally, note that $o , omega$ are equal to $O , Omega$ here as our limits exist.

#exercise(title: "Big Oh Arithmetic")[
  Prove the following:
  + $n^m = O(n^(m')) quad m <= m'$
  + $O(f(n)) + O(g(n)) = O(|f(n)| + |g(n)|)$
  + $f(n) = O(f(n))$
  + $O(O(f(n))) = O(f(n))$
  + $c O(f(n))= O(f(n))$ where $c$ is constent
  + $O(f(n)) dot O(g(n)) = O (f(n)g(n)) = f(n)O(g(n)) = g(n)O (f(n))$
  + $O(f(n)^2) = O(f(n))^2$
]

All this can be made useful in problems like: 

#exercise(title: "Sum of Power of Numbers")[
  Comment on the asymptotic behavior of $
  f_k (n) = sum_(i=1)^n i^k
  $ where $k, n in NN$. 
]
Let's start with some small cases. We know from school (and had proved using induction) that:
$
f_0(n) = sum_(i=1)^n i^0 =sum_(i=1)^n 1 = n = O(n)\
f_1(n) = sum_(i=1)^n i^1 =sum_(i=1)^n i = (n(n+1))/2 = O(n^2)\
f_2(n) = sum_(i=1)^n i^2 = (n(n+1)(2n+1))/6 = O(n^3)
$
This seems to indicate $f_k(n) = O(n^(k+1))$, but how do we prove this?

#proof[
  $
  &f_k (n)\
  =& sum_(i = 1)^n i^k\
  =& sum_(i = 1)^n O(n^k)\
  =& n dot O(n^k)\
  =& O(n^(k+1))
  $
]

This was literally simpler than induction!


= Graph Theory
Every so often we listen to statements along the lines "Your friends, on average, have more friends than you" or that "any 2 people can be connected to each other in 6 relations". How do we formalize and prove these? One of the ways to reason about networks may they be of people, roadways or anything else is *Graphs*.

#definition(title:"Simple Graph")[
  A graph is an ordered pair $G = (V, E)$ where $V$ is the set of *vertices* and $E subset.eq {{x,y} | x, y in V, x != y}$ is a set of unordered pairs of vertices called *edges*.
]

We also have a natural way of drawing a graph. For each vertex we have a point in the plane, and for each edge we draw a line between the corresponding pair of vertices.

We can also model some situations with one-sided relationships by the following definition
#definition(title : "Directed Graph")[
  In a directed graph, $E subset.eq {(x,y) | x, y in V, x != y}$. That is the pairs are ordered and hence, the edges *directed*.
]

These can be drawn by giving the edges arrowheads.

We can also give weights to each of the edge.
#definition(title : "Weighted (Directed) Graph")[
  In a (directed) graph coupled with a function $w : E -> RR$ is called a weighted (directed) graph.
]

#figure(image("karate-club.png", width: 60%), caption: [The Social Network of Friendships within a 34-person Karate Club (rather popular in CS and Network theory examples)])

If we wanted to spread a rumor quickly here, where would one start? What about if we wanted to split the club as people are talking too much during the practice?

#figure(image("delhi-metro.png", width: 60%), caption: [Delhi Metro])

Given two locations, how would we figure out the route to use? Is there a way to draw them more legibly?

#figure(image("erdos.png", width: 80%), caption: [Handrawn graph of Erdos's Collaborations])

Given a person, can we find their Erdos number efficiently? Who has the largest Erdos number?

#figure(image("parametrized-graph.png", width: 80%), caption: [Chapterwise dependencies from Parametrized Algorithms])

In what order should one do the chapters? Which of these chapters is the most important? Second most important? How do we even define important?

#figure(image("choice-tree.png", width: 60%), caption: [Part of the Choice Tree for a game I had developed])

Can we figure out if there is a loop? What scenes are visited the most?

#figure(image("indian-rail.png", width: 40%), caption: [Rail Network of India])

Given prices and two cities, what is the cheapest route? Fastest? If cost were to be cut and we need to shut down some of the rails without affecting connectivity, which should we shut down?

What I want to get on is that there are a lot of graphs and we want to answer a whole lot of questions about them. This is something we will look into in the coming classes and tutorials.

Let's define few more terms.

#definition(title: "Subgraph")[
  We say that $H = (V', E')$ is a subgraph of $G = (V,E)$ if $V' subset.eq V$ and $E' subset.eq E$.
]

Informally, H is a subgraph of G if we can remove vertices and edges from $G$ to get $H$.

We are also going to use some notation for removing an edge or a vertex from a graph. Of course, when removing a vertex you also have to remove the edges connecting to it.

#definition(title: "Adding/Removing Vertices & Edges")[
  For an edge $x y$ or a vertex $x$, we define $G - x y$ to be the graph $G$ with the edge $x y$ removed, and $G − x$ to be $G$ with vertex $x$ removed, along with all edges incident to $x$. 
  
  We will also define $G + x y$ to be $G$ with the edge $x y$, and $G + x$ to be $G$ with the vertex $x$.]



#definition(title:"Neighborhood")[
  If $x y in E$, then we say that $x$ and $y$ are adjacent or neighbors. 
  
  We define the neighborhood of $x$ to be the set $N(x) = {y in V |x y in E}$ of all vertices adjacent to $x$.
]

We also define
#definition(title:"Degree")[
  We define the degree of a vertex $x$ to be $"deg"(x) = |N(x)|$. This is equal to the number of edges that are incident to x.
]

This puts us in the position to prove our first theorem (and formalize something we said at the start of the class): "Your friends, on average, have more friends than you"

#lem(title: "Lemma (Handshake Lemma)")[
  For all graphs $G = (V, E)$
  $
  sum_(v in V) "deg"(v) = 2 |E|
  $
]<hand-shake>
#proof[
  Every edge contributes to the degrees of exactly 2 vertices. Thus, if we add the degrees, we should end up counting each of the edge twice.
]

#thm[
  For a graph $G = (V,E)$ with no isolated vertices, the average degree of a randomly selected vertex in a graph is less than the average degree of neighbors of a randomly selected vertex, that is:
  $
  sum_(v in V) "deg"(v) <= sum_(v in V) (sum_(n in N(v)) "deg(n)")/"deg"(v)
  $
  (omitting the denominator of $|V|$ on both the sides)
]
#proof[
  Using @hand-shake, we can substitute the left side with $2 |E|$.

  For the right hand side,
  $
  sum_(v in V) (sum_(n in N(v)) "deg"(n))/"deg"(v)\
  = sum_(v in V) (sum_(u v in E) "deg"(u))/"deg"(v)\
  = sum_(u v in E) (("deg"(u))/"deg"(v) + ("deg"(v))/"deg"(u))\
  >= 2 |E|
  $

  We use the fact that $a/b + b/a >= 2 <==> a^2 + b^2 >= 2a b <==> (a-b)^2 >= 0$ for the final statement.
]

This means this is not just a social or empirical phenomenon but a mathematical one. Two immediate consequences are:
  - Comparison is truly the thief of joy. If you look at the number of friends of your friends or the citations of people you cite or the followers of people you follow or the number of partners of your partner, you will most likely than not ne sad. The graph gives you good reason to feel that everyone else is doing better than you but that tells you nothing about how well you are actually doing (and in some of these cases, the graph is weighted and you might not be accounting for the weight!)

  - Say we want to find a high-centrality individual (we shall define this next time, but the name is somewhat self-descriptive), we can randomly choose a vertex and randomly choose one of it's neighbors. This is important in preventing the spread of rumors and, much more importantly, controlling pandemics. We could do even better in most social context: choose a vertex and choose it's neighbor with highest degree. This vertex has a quite high chance of being the highest degree vertex (which more usually than not is the center).
  
    For example: We can find the most followed person on Instagram by asking a random person the most famous person they follow with the odds of $(678 "million")/(3 "billion") approx 0.226$ which is a lot, lot better than random guessing. Even if we are not exactly correct, we probably won't be very far off.

    We can also do a time complexity analysis. If it costs $O(1)$ to query the degree of a vertex, then calculating all the degrees costs $O(|V|)$ while the above approach costs $EE(O("deg"(v))) = O((2|E|)/(|V|))$ which is true for quite a lot of graphs.

We will define some more terms for graphs as well as look at some algorithms on graphs next time.