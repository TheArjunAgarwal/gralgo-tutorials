#import "../style.typ": *



#show: main.with(
  title: [Graduate Algorithms],
  subtitle: [Problems on DP],
  date: datetime.today()
)

#quote(attribution: "Master Shifu, Kung Fu Panda 3")[
If you only do what you can do, you'll never be more than you are now.
]

This is not a complete exploration of DP. Barely scratching the surface. DP is such a rich topic that one could (and people do) spend whole careers working on it (and meanwhile resolving a lot of problems).

Furthermore, these are not all the DP ideas. Far from it. These are the ideas in the intersection of things I was aware of, was comfortable giving and has some real chance of appearing in the exam/quiz.

But I hope it is still fun.

= Warm Up

#exercise(title : "Jumper")[
There $n$ building on a line and the height of $i$-th building is $h_i$.

There is a man who wants to go to building $n$ from building $1$ by jumping rooftop to rooftop.

He can jump really high but each jump costs him $|h_i - h_j|$ stamina from $i$ to $j$.

But he can’t jump too far, so the gaps between building he can jump is
limited to $k$. That is. $j - i <= k$.

Also he can only jump forward.

Write an algorithm to figure out the minimum energy used in $O(n k)$.
]

= Classic

#exercise(title : "LCS")[
Given two strings $S$ and  $T$, find the Longest Common Subsequence.

Let a subsequence of $S$ is the result of deleting some(0 to All) characters in $S$.

E.g. $S = "\"abcde\""$; "", "abcde", "ae" are the subsequences of $S$, but "aeb" is not.

Reminder that Subsequence $!=$ Substring. (Substring is contiguous)

If $S = "\"abcdef\""$, $T = "\"ebbdaf\""$. Then there LCS is "bdf".
]

#exercise(title : "Max Sum")[
Let $A$ be an array of $n$ positive integers.
Consider function
$
f(k) = cases(0 "if" k = 0, max_(i=1)^k (A[i] + f(k-i)))
$

Compute $f$.
]

#exercise(title: "Rod Cutting")[
Given a rod of length $n$ and an array $P$ of length $n$ where $P[i]$ is the price for a rod of length $i$ sells for, for each $i in [1,n]$

Goal: Cut the rod into segments of integer lengths to maximize the revenue.
]

#exercise(title : "Edit Distance")[
Given two strings $A = a_1 a_2 dots a_m$ and $B = b_1 b_2 dots b_n$,

Compute Edit Distance aka the minimum number of operations to convert $A$ into $B$ where the allowed operations are:
- Insert a character
- Delete a character
- Substitute one character for another
]

#exercise(title : "Longest Increasing Subsequence")[
Given an array of integers $A[1 dots n]$, find the length of the longest strictly increasing
subsequence LIS.
]

#exercise(title : "Max Weight Subarray Again")[
Let $A$ be an array of $n$ integers ($A$ is not necessarily sorted). Each integer in $A$ may be positive or negative.

Given $i, j$ satisfying $1 <= i <= j <= n$,

Define sub-array $A[i : j]$ as the sequence $(A[i], A[i + 1], dots, A[j])$, and the weight of $A[i : j]$ as
$A[i] + A[i + 1] + dots + A[j]$. 

We already have an $O(n log n)$ algorithm for this. We now want to find an $O(n)$ algorithm using Dynamic Programming.
]

#exercise(title : "Subset Sum")[
  Given a list $A$ of $N$ integers, find a subset of integers that sums to $S$.
]

#exercise(title : "Knapsack")[
  Given a list $V$ of length $N$ of positive integers, a list $W$ of length $W$ of positive integers and capacity $C$; Choose a subset of $I$ of $[1,N]$ that maximizes:
  $
  sum_(i in I) V[i]
  $
  upto the constraint
  $
  sum_(i in I) W[i] <= C
  $
]

#exercise(title: "Walking")[
  The input to this problem is an $m times n$ array $C [0 dots (m − 1)][0 dots (n − 1)]$ of positive integers. 
  
  A valid path through this array is a path that starts at location $C [0][0]$ and ends at location $C [m − 1][n − 1]$ using (only) the following three types of steps: 
  - move to the right by one cell, 
  - move down by one cell,
  - move diagonally down and to the right by one cell. 

That is, if the path is currently at location C [i][j] then after one step it can be only at one of the following three locations: 
- $C [i][j + 1]; j < n$,
- $C [i + 1][j]; i < m$, 
- $C [i + 1][j + 1]; i < m, j < n$.

The cost of a valid path is the sum of all the array elements which the path touches, including the first and last elements in the path. The goal is to compute the least cost of a valid path through the input array $C$.
]

#exercise(title:"Integer Replacement")[
Given a positive integer $n$, you can apply one of the following operations:
- If $n$ is even, replace $n$ with $n/2$.
- If $n$ is odd, replace $n$ with either $n + 1$ or $n−1$.

Return the minimum number of operations needed for $n$ to become
$1$.
]

#exercise(title: "Word Break")[
  Given a string $s$ and a dictionary of strings `wordDict`, return true if
s can be segmented into a space-separated sequence of one or
more dictionary words.

Note that the same word in the dictionary may be reused multiple
times in the segmentation.
]


= Nice but not too hard
#exercise(title : "Longest Palindrome Sequence")[
  Given a string $S$ with length $N$. The target is to find the longest Palindrome Subsequence.

Here, Palindrome is a string $A$ such that the reverse of the $A$.

E.g. Longest Palindrome Subsequence of $"\"abcabca\""$ is $"\"abcba\""$.
]

#exercise(title : "Coin Change")[
  Given an unlimited supply of coins of denominations $x_1, x_2, dots , x_n$ , we wish to make change for a value $v$; that is, we wish to find a set of coins whose total value is $v$. Design an $O(n v)$ dynamic programming algorithm for solving this problem.
]

#exercise(title : "Password (ZIO 2025)")[
  You need to select a passcode consisting of $N$ numeric digits. Each digit can be between $0$ and $9$, both inclusive, and your passcode may have leading $0$s. Therefore, there are $10^N$ possible passcodes. Let $D_i$ denote the $i$th digit of your passcode (1 indexed).
  
  To make your passcode difficult to guess, you make sure that:
  - No two adjacent digits are equal. That is, for all $1 <= i <= N-1, D_i != D_(i+1)$.
 - For any three consecutive digits, they are not all increasing. That is, there must be no $1 <= i <= N-2$ such that $D_i < D_(i+1)$ and $D_(i+1) < D_(i+2)$.

- For any three consecutive digits, they are not all decreasing. That is, there must be no $1 <= i <= N-2$ such that $D_i > D_(i+1)$ and $D_(i+1) > D_(i+2)$.
- 
For a given length $N$, what is the number of passcodes you can create of that length?
]

#exercise(title : "Triangle Path (IOI P1, 1994)")[
```
    7
   3 8
  8 1 0
 2 7 4 4
4 5 2 6 5
```
Given above is a number triangle. Our question concerns such triangles. Write a program that calculates the highest sum of numbers passed on a route that starts at the top of a number triangle and ends somewhere on the base of the number triangle. Note: Each step can go either diagonally down to the left or diagonally down to the right.

For the example given above, the answer is $30$ via $7 -> 3 -> 8 -> 7 -> 5$.
]

#exercise(title : "Matrix Multiplication")[
  Let us assume for any two matrices $A$ and $B$ whose dimension are $m times n$ and $n times p$. We define the cost of multiplying $A$ and $B$ as $m n p$ (we know this is not the most efficient but for the sake of argument). Given $n$ matrices $A_1, dots , A_n$, where the $i$-th matrix has dimension $m_(i−1) times m_i$, Design an efficient algorithm for determining the minimum cost for multiplying all $n$ matrices. Note that multiplying the matrices in different orders might change the total cost.
]

#exercise(title: "Wine Barrels")[
*Problem:* There are $N$ barrels of wine stored in a narrow passage. Each
year, you sell either the first or the last barrel. The $i$-th wine has initial price $P[i]$, and sells for $k dot P[i]$ in the $k$-th year.

*Goal:* What is the maximum possible total profit?
]

#exercise(title: "Post Office (IOI P5, 2000")[
There is a straight highway with villages alongside the highway. The highway is represented as an integer axis, and the position of each village is identified with a single integer coordinate. There are no two villages in the same position. The distance between two positions is the absolute value of the difference of their integer coordinates.

Post offices will be built in some, but not necessarily all of the villages. A village and the post office in it have the same position. For building the post offices, their positions should be chosen so that the average distance from each village to its nearest post office is minimized.

You are to write a program which, given the positions of the villages and the number of post offices, computes the least possible sum of all distances between each village and its nearest post office, and the respective desired positions of the post offices.
]

#exercise(title: "Pot's Of Gold (DS-Algo Quiz 2)")[
*Problem:* Let $G[0 dots (n − 1)]$ be an array of $n$ positive integers. 

In the pots-of-gold game, there are $n$ pots  $P_0, P_1, . . . , P_(n−1)$ lined up in a row, and pot $P_i$ contains $G[i]$ gold coins. Two players start with an empty bag each, and they take turns removing exactly one pot from either end of the row. 

Each player adds the gold coins from the removed pot to their own bag. The game ends when no pots remain.

*Our goal:* find the maximum total gold that the first player can guarantee to collect, no matter how the second player responds.
]


#exercise(title: "Blackbeard's Ship (DS-Algo Mock Midsem 2026)")[
  Ace has been captured by Blackbeard and is held prisoner aboard the Saber of Xebec, a massive ship with $n$ cabins. Blackbeard is demanding a hefty ransom.

  Nami, negotiating on behalf of the Straw Hats, agreed to the following terms. She will guess the cabin number where Ace is held. If she guesses correctly, Blackbeard releases Ace immediately. Otherwise, if her guess is too high, Blackbeard informs her of this and she pays him $a$ Berries. If her guess is too low, she pays $b$ Berries.

  (a) Write the complete psudocode for a recursive algorithm `search_price(n, a, b)` that computes the minimum cost Nami can incur in this search by using the optimal strategy, irrespective of where Ace is imprisoned.

  (b) In terms of $n, a, b$, What is the runtime of your recursive solution?

  (c) Write the psudocode for the memoized version of your algorithm from part (a) without using any libraries or decorators or language features.
  ]

= DP on Graphs
#exercise(title : "Travelling Rockstar")[
  Given $n$ cities and a table $T$ such that $T[i][j]$ is time it takes to go from city $i$ to city $j$.

  A rockstar wants to have a tour covering all the $n$ cities. Can you find a tour that minimizes the travel time?

  Note: We want a $O(n^2 2^n)$ algorithm.
]


#exercise(title: "All Pairs Shortest Path")[
  Given a weighted graph $G = (V, E)$, design an algorithm to compute the shortest path distances between every pair of vertices in $V$.

  Note: We would like a $O(|V|^3)$ algorithm.

  Hint: The algorithm is dumber than you could think of. It is like so, so dumb!
]

#exercise(title : "Single Source Shortest Path")[
  Given a weighted graph with positive weights $G = (V,E)$, a start location $S$ and target location $T$; design an algorithm to find the shortest path from $S$ to $T$.

  Note: This algorithm's story is like one of the coolest thing I know of.
]

#exercise(title : "Party")[
  You are organizing a party for your office. Unfortunately, the office is very hierarchial and people don't feel comfortable attending a party if their immediate senior is attending (although they have no issues with others. Basically, you and boss of your boss can be invited but not you and your boss).

  Given a list $S$ of length $n$ with $S[i]$ being the immediate underlings of $i$ ($S[j]$ being $-1$ indicates $j$ is at the bottom of the hierarchy). Everyone has only one immediate boss.

  What is the most number of people you can invite?

  Hint: We want a $O(n)$ algorithm
]

#exercise(title : "Party with Money")[
  Same setup as *Party* but we need money to even do this party. Every person has an amount of money they are willing to contribute. We want to invite the people, in an attempt to maximize the amount of money we have to party. Can you do that in $O(n)$?
]

#exercise(title : "Root Replace DP")[
  Given a tree with $n$ nodes, find a node such that when this node is the root, the sum of the depths of all nodes is maximized.

  Note: This can be done in $O(n)$ time as well.
]

= Some Other DP Ideas

#exercise(title : "Digital DP")[
  Given positive integers $a$ and $b$, How many times does each digit appear in all integers $[a, b]$?

  Hint: We can solve this in $O(log_10 (b))$.

  Hint: $9000 -> 9900 -> 9990 -> 9999$ also seems like a valid way to count... doesn't it?
]

#exercise(title: "Polynomial DP (DS-Algo Mock Midsem 2026)")[
  Given a $m$, `count_poly(m)` counts the number of polynomials $P$ with coefficients from ${0,1,dots,9}$ such that $P(3) = m$.

    #align(center)[
    #table(
      columns: 2,
      [*Input*], [*Output*],
      [m = 1], [1],
      [m = 3], 
      [2], 
      [m = 10], 
      [4]
    )
  ]

  *Hint:* Notice that there are no negative coefficients in $P$.

  (a) Write psudocode implementing `count_poly(m)` in $O(m log_3(m))$ time.

  (b) Argue the correctness of your implementation.
]

#exercise(title : "Just a normal DP")[
  Given a positive integer $n$, determine how many ways it can be expressed as the sum of $k$ positive integers, where different orders are considered distinct partitions.
]

#exercise(title : "Another normal DP")[
  Starting with an empty list $[]$, we have two operations.
  - Increase all the elements with 1
  - Append 1 to the list

Given an $n$, what is the minimum number of operations we need to make the sum of the list $n$?
]

#exercise(title : "Oh, that's why they were there!")[
  Given a positive integer $n$, how many ways are there to partition $n$ into a sum of any number of positive integers? (Different orders are considered the same partition.)

  Hint: A strategy similar to *Just a normal DP* will give an $O(n^2)$ solution. Similarly, *Another normal DP* might also provide a $O(n^2)$ solution.

  Extension: Looking at the solutions, can you see some part of the solution that uses more time in both? Notice that these are both disjoint. So maybe we can combine both the solutions? This would give an $O(n sqrt(n))$ solution.
]
