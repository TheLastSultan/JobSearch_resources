# Big O Notation

In the CatMatch problem, we said that Phase II, which compared every
pair of cat profiles and took `n*(n-1)/2 * 1` time **dominated** Phase
I, which took `n * 1000` time. A function `f(n)` **dominates** another
function `g(n)` if

    lim_{n -> ∞} g(n)/f(n) = 0

This means that as `n` gets larger and larger, `g(n)` is smaller and
smaller compared to `f(n)`. This is exactly what happened with the
time it takes to run Phase II and the time it takes to run Phase I.

We define
    `O(f) = { g | g does not dominate f}`.

Note that `O(f)` is a **set of functions**. Here is a table of
examples:

`f` |`g`  |`f` dominates `g`? |`g` dominates `f`? |`f` in `O(g)` |`g` in `O(f)`
----|-----|-------------------|-------------------|--------------|-------------
1   |1    |false              |false              |true          |true
1   |n    |false              |true               |true          |false
n   |n    |false              |false              |true          |true
n   |n**2 |false              |true               |true          |false

To be hyper-accurate, we would say that the function `f(n) = n` is in
the set `O(n**2)` (since `n**2` dominates `n`). Speaking less
formally, we say that `f(n) = n` *is* `O(n**2)`.

Note that `O(n**2)` includes functions that are dominated by `n**2`.
If we want to talk about sets of functions, all of which do not
dominate each other, there is a second set we use sometimes called
`Θ(f)`.

    Θ(f) = { g | g does not dominate f, and f does not dominate g }

This is often called "big theta". Big theta is more specific than big
O: when we say `g` is in `O(f)`, we are saying that `g` does not grow
to dominate `f`. When we say `g` is in `Θ(f)`, we are saying that `g`
does not grow to dominate `f`, AND `g` grows at fast enough to keep up
with `f`.

In general practice, most people just talk about big O and avoid
misleading, silly statements like: "n is in O(n**3)". While accurate,
this would tend to overstate the growth of `n`.

Why not always use big theta? The reason is that it is often easy to
compute conservative over-estimates of time complexity, which will
give us an upper bound on how fast the function grows. It is often
more difficult to compute lower-bound estimates to establish that an
algorithm does not run *too* fast.

Basically, the math is harder, so we don't do it.

## Some Big O Theorems

```
Say:
f_1 is in O(f_2),
f_2 is in O(f_3),
THEN f_1 is in O(f_3).

Proof:

Since f_2 is in O(f_3), there exists an M and N such that, for all
n>N, f_2(n)/f_3(n) < M (otherwise the limit would not exist or be
infinity). So:

f_1(n)/f_3(n) = (f_1(n)/f_2(n)) * (f_2(n)/f_3(n)) < M * f_1(n)/f_2(n)

But we know that f_1 is in O(f_2), so the limit of f_1(n)/f_2(n) is
non-infinite. Multiplying this by the constant M results in a limit
which is also finite, so f_1 is in O(f_3).
```

An immediate corrolary is that if:

```
If f in O(g) and g in O(f), then O(g) = O(f).
```

For this reason, we never say things like `O(2n**2)`; instead we
simplify and say `O(n**2)`.

We've seen that Phase I of CatMatch is `O(n)` while Phase II is
`O(n**2)`. What is the time complexity of CatMatch overall?

The time complexity of an algorithm is always the worst of the time
complexities of its components.

```
Say:

f_1 in O(g_1),
f_2 in O(g_2),
AND g_1 is in O(g_2).

THEN, if f(n) = f_1(n) + f_2(n), f is in O(g_2).

Proof:

lim_{n -> ∞} (f_1(n) + f_2(n)) / (g_2(n))
    = (lim_{n -> ∞} f_1(n) / g_2(n)) + (lim_{n -> ∞} f_2(n) / g_2(n))

Since f_1 is in O(g_1), and g_1 is in O(g_2), then f_1 must be in
O(g_2), by the transitivity theorem above. Therefore the first limit
is equal to zero.

We know the second limit is finite, since f_2 must not dominate g_2,
or else it would not be in O(g_2).

Therefore the sum of the limits is finite, so f is in O(g_2).
```

In simple terms: the time complexity of the worst bottleneck in your
algorithm is the timecomplexity of the whole algorithm.

## Analyzing polynomials

When dealing with [polynomial functions][polynomial] of the form:

    a_p x**p + a_p-1 x ** (p-1) + ... + a_1 x + a_0

for instance,

    n**3 + 2n**2 + 1

then we can just **look at the highest power**. Consider:

    does n**3 dominate 100n**2 + 10n + 900?

We know that `n**3` crushes `n**2` because

    lim n**2/n**3 = lim 1/n = 0

`n**3` still crushes `100n**2`; the constant factor does not change
the rate of growth of the quadratic term. The smaller terms of
`100n**2 + 10n + 900` are negligable; if the biggest term is crushed,
all the smaller ones will be too.

[polynomial]: http://en.wikipedia.org/wiki/Polynomial

## Run-time

Just because two algorithms belong to the same complexity class
doesn't mean they will take the same amount of time to solve the same
size of problem. For instance, here's an algorithm to find the
smallest number in an array:

```ruby
def min(nums)
  min = nums.first
  nums.each { |n| min = n if n < min }

  min
end
```

This does one comparison per element, for `n` comparisons total. The
algorithm is linear in the number of elements. Here's a second
algorithm, which finds the two smallest numbers:

```ruby
def two_min(nums)
  min1, min2 = nums[0], nums[1]

  nums.each do |n|
    if n < min1
      min1, min2 = n, min1
    elsif n < min2
      min2 = n
    end
  end

  return [min1, min2]
end
```

This does two comparisons for each element in the array, for `2n`
comparisons total. This is again linear in the number of elements, but
we expect it to be about twice as slow.

Remember: time complexity is about *dominance* and bottlenecks, not
mere speed. `two_min` and `min` are equally bad as far as being a
bottleneck.
