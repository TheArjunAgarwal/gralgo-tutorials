#import "../style.typ": *



#show: main.with(
  title: [Graduate Algorithms],
  subtitle: [Problems on Divide and Conquer - Answers],
  date: datetime.today()
)

#quote(attribution: "Drew Gooden")[What's rewarding about making stuff is figuring it out on your own or with a group of people and getting to share in that feeling. 

I understand how tempting a shortcut can be, especially when you go online and you see all these other people doing cool things and you're like,'man, I'll never be that talented. It would take me like 10 years to learn how to make music like that.' 

Okay, that's fine. What's the rush? Just start right now. Don't worry about how long it's going to take. Just take the first step. How are you ever going to do something for 10 years if you won't even do it for one day? 

Maybe you won't be good at something the first time you do it. You probably won't. But every time you improve, that's something that you can feel proud of. That's something that you did.]

#exercise(title : "Counting Inversions")[
Given an (1-indexed) array $A$ of $n$ distinct integers, Give an algorithm to count the number of inversions in $O(n log n)$

An inversion is a pair of $i,j$ such that
- $1 <= i < j <= n$
- $A[i] > A[j]$

Hint: Consider a function `def inversions(A: list[int]) -> tuple[int, list[int]]` where we are returning both the number of inversions and sorted list `A`.
]

Let there be two sorted $X$ and $Y$ such that X ++ Y = A. What can we say about $"inversions"(A)$?

As $X$ and $Y$ are sorted, there are no inversions in $X$ or $Y$. We now need to consider the inversions between $X$ and $Y$. We could do so trivially in $|X| dot |Y|$ time. However, notice, if for some $i, j$; $X[i] > Y[j]$ then we can simply add $|X| - i$ inversions as $X[i+1] > Y[j], X[i+2] > Y[j], dots$.

This means, we could run a merge procedure (similar to merge sort) on $X, Y$ and make a count of inversions on the way. This would take $O(|X| + |Y|) = O(|A|) = O(n)$ time.

Using the above idea, we could simply split our array into two equal parts $X$ and $Y$; count the number of inversions in each of these parts while sorting it and then merging them to count the inversion between them. The pseudocode would look like:
#psudo(title: "Inversions")[
  + def InverMerge(X, len_x, Y, len_y):
    + if |X| = 0:
      + return (0, Y)
    + if |Y| = 0
      + return (0, X)
    + if X[1] >= Y[1]:
      + (inv, lis) = InverMerge(X[2-n], len_x-1, Y, len_y)
      + return (inv, X[1] ++ lis)
    + if X[1] < Y[1]:
      + (inv, lis) = InverMerge(X, len_x, Y[2-n], len_y)
      + return (inv + len_x, Y[1] ++ lis)
  
  + def Inversions(A):
    + n = len(A)
    + X = A[$1-floor(n/2)$]
    + Y = A[$(floor(n/2)+1) - n$]
    + (inv_X, lis_X) = Inversions(X)
    + (inv_Y, lis_Y) = Inversions(Y)
    + (inv, lis) = InverMerge(lis_X, $floor(n/2)$, lis_Y, $ceil(n/2)$)
    + return (inv_X + inv_Y + inv, lis)
]

We can see that the time complexity is $T(n) = 2 T(n/2) + O(n) => T(n) = O(n log n)$ as desired.

#exercise(title : "Strassen's Algorithm")[
Given two $n times n$ matrices $A$ and $B$, compute their product $A B$ in time $O(n^(log_2 7))$

Assuming $m>= n$, can you find an $O(m^2 n^(0.81))$ algorithm to multiply $A$ a $m times n$ and $B$ a $n times m$ matrix using the above a subroutine. (Hint: Multiply $ceil(m/n)^2$ pairs of order-n matrices)

Assuming $m >= n >= t$, Can you find an $O(m n t^(0.81))$ algorithm to multiply $A$ a $m times n$ and $B$ a $n times t$ matrix using the above a subroutine. (Hint: Multiply pairs of $t times t$ matrices)
]

The idea for the first part is that $O(n^(log_2 7))$ is perhaps the result of the recurrence $T(n) = 7 T(n/2) + Omega(n^(log_2 7))$.

Note, the $Omega$ at the end. Any merge step taking time less than $n^(log_2 7)$ is enough.

Thus, we consider splitting the $n times n$ matrix into 4 $n/2 times n/2$ matrices. Let

$
A = mat(A_(11), A_(12); A_(21), A_(22)), quad B = mat(B_(11), B_(12); B_(21), B_(22))\
=> A dot B = mat(A_(11) B_(11) + A_(12) B_(21), A_(11) B_(12) + A_(12) B_(22); A_(21) B_(11) + A_(22) B_(21), A_(21) B_(12) + A_(22) B_(22))
$

Thus, we have a way to solve our multiplication by solving $8$ products. Sadly, $T(n) = 8 T(n/2) + O(n^2) => T(n) = O(n^(log_2 8)) = O(n^3)$.

So we want to reduce the number of multiplications to 7. As it turns out, if you stare at this long enough, you can do that. Check out https://cs.stackexchange.com/a/130028 for the intuition. This is named Strassen's Algorithm.

*For the next part*, Since $m >= n$, we can view the tall matrix $A$ as a vertical stack of $n times n$ blocks and the wide matrix $B$ as a horizontal row of $n times n$ blocks (upto padding with $0$s). Let $q = ceil(m/n)$.

Basically,
$
A = mat(A_1;A_2; dots; A_q), B = mat(B_1, B_2, dots, B_q)
$
where each $A_i$ and $B_j$ is an $n times n$ block. The resulting product $C = A B$ is an $m  m$ matrix consisting of $q^2$ blocks, where each block $C_(i j)$ is defined by:
$
C_(i j) = A_i dot B_j
$

Since each $A_i$ and $B_j$ is $n times n$, we can compute each $C_(i j)$ using the Strassen's Algorithm in $O(n^(2.81))$.

We perform $q^2$ multiplications. Since $q approx m/n$, the total time is:
$
O((m/n)^2 n^(2.81)) = O(m^2 n^(0.81))
$


*For last part*, Now we have $m >= n >= t$. The goal is to reach $O(m n t^(0.81))$. Following the logic from Part (a), we should partition everything into $t times t$ blocks (upto padding by 0s).

1. Partition $A$ ($m times n$) into a grid of blocks $A_(i,j)$ where $1 <= i <= m/t$ and $1 <= j <= n/t$.
2. Partition $B$ ($n times t$) into a vertical stack of blocks $B_(j,1)$ where $1 <= j <= n/t$.
3. The resulting matrix $C$ ($m times t$) will have $m/t$ blocks.

Each block $C_(i,1)$ of the output is computed as:
$
C_(i,1) = sum_(j=1)^(n/t) A_(i,j) dot B_(j,1)
$


To compute one block $C_{i,1}$, we perform $n/t$ multiplications of $t times t$ matrices. There are $m/t$ such blocks in $C$.
Hence, we made a total of $m/t dot n/t = (m n)/t^2$ multiplications. Each multiplication takes $O(t^(2.81))$.

Hence, the total time complexity is $O(m n t^(0.81))$.

#exercise(title: "Merging Arrays")[
Let $A_1, A_2, dots, A_k$ be $k$ arrays, each of which has been sorted.

These arrays are mutually disjoint, namely, no integer can appear in more than one array. 

Design an algorithm to merge the $k$ arrays into one sorted array in $O(n log k)$ time, where $n$ is the total length of the $k$
arrays. 

Note: these arrays may have different lengths.
]

The idea is rather boring and better elucidated by pseudocode.
#psudo(title: "Merging Arrays")[
  + def Merge(X, Y):
    + if |X| = 0
      + return Y
    + if |Y| = 0
      + return X
    + if X[1] >= Y[1]:
      + lis = Merge(X[2-n], Y)
      + return X[1] ++ lis
    + if X[1] < Y[1]:
      + lis = Merge(X, Y[2-n])
      + return Y[1] ++ lis
  + def Merge_Arrays(A : List of Lists -> List):
    + k = len(A)
    + if k = 0:
      + return []
    + if k = 1
      + return A[1]
    + A_left = Merge_Arrays(A[$1-floor(k/2)$])
    + A_right = Merge_Arrays(A[$(floor(k/2) +1) - k$])
    + return Merge(A_left, A_right)
]

Notice, the recurrence here is a bit more interesting.
$
T(n, k) = T(sum_(i = 1)^(floor(k/2)) A_i, floor(k/2)) + T(sum_(i = floor(k/2) + 1)^(k) A_i, ceil(k/2)) + O(n)\
$

This seems completely impenetrable. So what do we do? 

Notice that at every step, every element of the lists is moved atmost twice (once in the `Merge_Arrays` and once in `Merge`). This implies, we could sort of get rid of the $n$ from the recurrence. This could allow us to say:
$
T(k) = T(floor(k/2)) + T(ceil(k/2)) + O(n)
$

which is the same recurrence as MergeSort and admits a similar answer: the recurrence tree can go atmost down till $log k$ levels. The nodes at each level sum upto $n$. Thus, $T(k) = O(n log k)$.

#exercise(title : "Max Weight Subarray")[
Let $A$ be an array of $n$ integers ($A$ is not necessarily sorted). Each integer in $A$ may be positive or negative.

Given $i, j$ satisfying $1 <= i <= j <= n$,

Define sub-array $A[i : j]$ as the sequence $(A[i], A[i + 1], dots, A[j])$, and the weight of $A[i : j]$ as
$A[i] + A[i + 1] + dots + A[j]$. 

For example, consider $A = (13, −3, −25, 20, −3, −16, −23, 18); A[1 : 4]$ has weight $5$, while $A[2 : 4]$ has weight $−8$.

+ Give an algorithm to find a sub-array of with the largest weight, among all sub-arrays $A[i : j]$ with $j = n$. Your algorithm must finish in $O(n)$ time.

+ Give an algorithm to find a sub-array with the largest weight in $O(n log n)$ time (among all the possible sub-arrays).
]

*For part $1$*, Let $s_i = a_i + a_(i+1) + dots + a_n$. Notice, $s_(i+1) = s_i - a_i$. Using this, we can compute $s_1$ to $s_n$ in $O(n)$ time and then find the maximum element.
#psudo(title: "Max Weight Subarray I (suffix)")[
  + def solveI_suffix(A):
    + n = len(A)
    + suf $<-$ empty array of length n
    + suf[n] = A[n]
    + for i in (n-1, 1, -1):
      + suf[i] = suf[i+1] - a[i+1]
    + return max(suf)
]

We could also do this by computing $p_i = a_1 + a_2 + dots + a_i$ and noticing $s_i = "sum"(A) - p_(i-1) = p_n - p_(i-1)$ and $p_(i+1) = p_i + a_(i+1)$.

#psudo(title: "Max Weight Subarray I (prefix)")[
  + def solveI_prefix(A):
    + n = len(A)
    + pre $<-$ empty array of length n
    + pre[1] = A[1]
    + for i in (1, n-1):
      + pre[i] = pre[i-1] + a[i]
    + return (pre[n] - min(pre))
]

Both of these are clearly $O(n)$ as it takes $O(n)$ time to make the prefix/suffix arrays and then $O(n)$ time to get the minimum/maximum element.

*For part $2$*, consider splitting $A$ into two arrays $L$ and $R$ (such that L ++ R = A). The maximum weight sub-array is either completely in $L$, completely in $R$ or between them.

If it is between them, then has to be the sum of the max weight suffix of $L$ and max weight prefix of $R$. This gives us the following pseudocode
#psudo(title : "Max Weight Subarray II")[
  + def MaxWeightSubarray(A):
    + n = len(A)
    + L = A[$1-floor(n/2)$]
    + R = A[$(floor(n/2)+1) - n$]
    + max_L = MaxWeightSubarray(L)
    + max_R = MaxWeightSubarray(R)
    + pre $<-$ empty array of length $floor(n/2)$
    + pre[1] = A[1]
    + for i in (1, $floor(n/2)$):
      + pre[i] = pre[i-1] + a[i]
    + suf $<-$ empty array of length $ceil(n/2)$
    + suf[n] = A[n]
    + for i in ($ceil(n/2)-1$, 1, -1):
      + suf[i] = suf[i+1] - a[i+1]
    + max_LR = max(pre) + max(suf)
    + return max(max_L, max_R, max_LR)
]

Notice, the time completely is $
T(n) =& T(floor(n/2)) + T(ceil(n/2)) + O(floor(n/2)) + O(ceil(n/2))\
=& T(floor(n/2)) + T(ceil(n/2)) + O(n)
$
which is same as MergeSort and thus, $T(n) = O(n log n)$.

#exercise(title : "L Tiles")[
  Given a grid of $2^N times 2^N$, all cells are initially empty except one of the cells. Let the blocked cell be $B$.

  Write an algorithm to  figure out a way to fill the grid with L shapes (without overlaping other tiles or $B$) or report "NO" if that is not possible. Your algorithm should run in $O(2^N)$.

  The $N = 2, B = (3,2)$ case is given below.

  #image("l-shape.png", width: 30%)

  Hint : We never have to return "NO".
]
This is just the algorithms version of a classic induction question.

The idea is to divide the $2^N times 2^N$ square into 4 $2^(N-1) times 2^(N-1)$ squares. One of these has a hole and is a smaller instance of our original problem. For the other 3, we put the first L to cover a square each. The diagram might make it more clear.

#image("l-shape-ans.png", width: 30%)

Thus, we can induct on the smaller squares to show that a tiling always exists (formalizing the proof is left upto reader).

Finally, notice that for 3 of the instances, the tilings are isomorphic. Thus, $T(n) = 2 T(n - 1) + O((2^(2n - 2) - 1)/3) = 2 T(n-1) + O(4^n) => T(n) = O(4^n)$ as desired.

#exercise(title : "Big Mod")[
  Given $p, e, b$, compute $p^e mod b$ in $O(log e)$ time.
]

The idea is that $p^e = (p^(e/2))^2$. The algorithm is simple:
#psudo(title: "Big Mod")[
  + def modExp(p,e,b):
    + if e = 0:
      + return 1
    + if e = 1:
      + return p mod b
    + if e mod 2 == 0:
      + return (modExp(p, e/2, b)$)^2 mod b$
    + else:
      + return p $*$ modExp(p, e-1, b) $mod b$
]

The complexity is $T(e) = T(floor(e/2))+ O(1) => T(e) = O(log e)$ as desired. 

#remark[
We technically have ignored the time taken to multiply two $n$ bit integers. Let $M(n)$ be the time to multiply two $n$ bit integers.

As the multiplications are modulo $b$, $n$ is bounded by $log(b)$. Thus, we would have $O(log(e) M(log(b)))$.

The best known bounds for $M(n) = O(n log n)$ (Harvey, van der Hoeven 2019) while we can achieve $M(n) = O(n log n log log n)$ using stuff we have seen in the course.
]

#exercise(title: "DeadShot (DS Algo Mock-Midsem 2026)")[
  To celebrate the end of midsems, a group of students head to the CLAB to play Deadshot.io. There are $n$ players participating, and the $i$th player has a skill score of $A[i]$. 

  They want to split into two teams for a match. They agree to the following rules:

  - Team Kabir must have a total skill score greater than or equal to Team Piyush.
  - The difference between the total skill scores of the two teams should be as small as possible.

  Write a function `balanced_teams(A)` that returns the minimum possible difference between the total skill scores of Team Kabir and Team Piyush under these rules in $O(n 2^(n/2))$ time.

  #align(center)[
    #table(
      columns: 3,
      [*Input*], [*Output*], [*Explanation*],
      [A = [5,4,7,6]], [0], 
      [Team Kabir gets 5 + 6 = 11 and \ Team Piyush gets 4 + 7 = 11 skill.],
      [A = [10, 1, 1]], 
      [8], 
      [Team Kabir gets 10 skill \ Team Piyush gets 1 + 1 = 2 skill.],
      [A = [3,4,2,2]], 
      [1], 
      [Team Kabir gets 4 + 2 = 6 skill \ and Team Piyush gets 3 + 2 = 5 skill.]
    )
  ]
  *Hint*: The intended solution uses $O(2^(n/2))$ space as we need *two* arrays of that length...( This should ring some bells)

  (a) Write pseudocode implementing `balanced_teams(A)`. You are not allowed to import libraries or use any language specific features.

  (b) Argue that your algorithm runs in $O(n 2^(n/2))$.

  (c) Argue the correctness of your implementation.
]

There is an obvious brute force $O(2^n)$ algorithm where we consider each possible partition. How do we make it faster?

Consider splitting the list into two halves $L$ and $R$. Consider the partitions of $L$ and partitions of $R$, given a partition in $L$, we want to find it's best mate in $R$.

This would trivially take $O(2^(n/2) * 2^(n/2)) = O(2^n)$ time. However, we could do better if we sort the partitions of $L$ and $R$ according to $T_k - T_p$. We can now find an optimal set as follows:
#psudo(title: "Balanced Teams I")[

  + def balanced_teams(A):

    + n $<-$ length(A)

    + m $<-$ floor(n / 2)

    + L $<-$ all signed sums obtainable from A[1..m]
    + R $<-$ all signed sums obtainable from A[m+1..n]

    + sort(L) in increasing order
    + sort(R) in increasing order

    + i $<-$ 1
    + j $<-$ length(R)

    + ans $<-$ infinity

    + while i <= length(L) and j >= 1:
      + while j > 1 and L[i] + R[j - 1] >= 0:
        + j $<-$ j - 1

      + if L[i] + R[j] >= 0:
        + ans $<-$ min(ans, L[i] + R[j])

      + i $<-$ i + 1

    + return ans
]

The cost is dominated by sorting and hence, the time complexity is $O(2^(n/2) log(2^(n/2)))= O(n/2 2^(n/2)) = O(n 2^(n/2))$ as desired.