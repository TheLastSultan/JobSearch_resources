# Time complexity

## CatMatch

Say I want to adopt two cats at the SF SPCA. I want to adopt the most
compatible pair of cats: the ones who will get on best with each other.
I will describe an algorithm to do this.

**Phase I**: I will have a psychologist interview each cat. The
psychologist will talk with each cat, giving them scores on a variety
of measures. The psychologist files a report on each cat, producing a
table like:

name     |jumping|meowing|napping
---------|-------|-------|------
markov   |0.5    |0.75   |0.1
curie    |0.9    |0.6    |0.8
breakfast|0.2    |0.3    |0.6

The idea is that each row describes a cat's personality. In
pseudo-code, we could write something like:

```ruby
def cat_profiles(cats)
  # using each explicitly for clarity; later you should use `map`
  cat_profiles = []
  cats.each do |cat|
    # we won't get into how an individual cat is profiled.
    cat_profiles << cat_profile(cat)
  end

  cat_profiles
end
```

**Phase II**: To find the most compatible cats, we need to compare
their personality profiles. Perhaps we believe that the two cats with
the most similar personality profiles will be the most compatible. Our
assumption is that similarities attract.

Let's not concern ourselves overly with how we evaluate the similarity
of the cat profiles. A natural choice might be to treat the profiles
as points in an 3-dimensional space; the "similarity" could be -1
times the distance between the two points. But that part isn't very
important.

A straightforward way to find the most similar pair of cats is like so:

```ruby
def best_pair(cat_profiles)
  best_pair, best_similarity = nil, nil
  cat_profiles.each do |(cat1, profile1)|
    cat_profiles.each do |(cat2, profile2)|
      next if cat1 == cat2

      # we won't get into how two profiles are compared.
      similarity = similarity(profile1, profile2)
      next if best_similarity && best_similarity > similarity

      best_pair, best_similarity = [cat1, cat2], best_similarity
    end
  end

  best_pair
end
```

This runs the inner block *for every pair of cats*. It computes their
similarity, and checks whether this is better than the best similarity
we've seen thus far.

## How Fast Is CatMatch?

How fast is our algorithm to solve CatMatch.

This depends on two things: the number of cats we're profiling, and
the amount of time it takes to execute `cat_profile(cat)` and
`similarity(profile1, profile2)`. Treating the number of cats and
these times as variables, the equation for the total time to run the
algorithm is:

```
TIME_TO_RUN_ALGORITHM =
  (NUMBER_OF_CATS) * (TIME_TO_PROFILE_CAT)
  + (NUMBER_OF_CAT_PAIRS) * (TIME_TO_COMPARE_PROFILES)
```

A key question is what is `NUMBER_OF_CAT_PAIRS`. Each pair consists of
two different cats. If there are `n` cats total, then there are `n`
choices for the first cat, and `n-1` choices for a second, different
cat. That means there are `n(n-1)` pairs.

However, notice that the pair `(markov, curie)` and `(curie, markov)`
both contain the same two cats. Every pair has a twin in reverse
order. So the total number of *unordered pairs* is `n(n-1)/2`.

Using this equation, we have:

```
TIME_TO_RUN_ALGORITHM =
  n * (TIME_TO_PROFILE_CAT)
  + (n(n-1)/2) * (TIME_TO_COMPARE_PROFILES)
```

I've continued to use `n` to stand for the number of cats. Now, if we
know the number of cats and the time it takes to profile a cat and
compare two profiles, we can calculate the time for the whole
algorithm.

## Behavior As The Number of Cats Grow

Let's say that it takes 1,000sec for the psychologist to conduct an
extensive cat interview. On the other hand, once we've boiled down the
cat to a series of numbers, let's say it takes 1sec to compute the
similarity of two profiles. Then:

    TIME_TO_RUN_ALGORITHM = n * 1000 + (n(n-1) / 2) * 1

Breaking this out in a table:

Number of cats|Time for Phase I|Time for Phase II|Total Time
--------------|----------------|-----------------|----------
10            |10,000          |45               |10,045
100           |100,000         |4,950            |104,950
1,000         |1,000,000       |499,500          |1,499,500
10,000        |10,000,000      |49,995,000       |59,995,000
100,000       |100,000,000     |4,999,950,000    |5,099,950,000

What we see here is that the time for Phase I grows **linearly** in
the number of cats: if we 10x the number of cats, Phase I takes 10x as
long.

On the other hand, the time for Phase II grows **quadratically** in
the number of cats: if we 10x the number of cats, Phase II takes
approximately 100x as long.

We say that Phase II **dominates** Phase I as the number of cats
increases. With 10 cats, Phase II takes 0.45% of the total time. With
100 cats it takes 4.7% of the total time. With 1,000 cats it takes 33%
of the total time. With 100,000 cats, it takes 98% of the total time.

As the number of cats increases, the percentage of time spent in Phase
II will grow to be closer and closer to 100%. This happens because
quadratic functions grow faster and faster than linear functions.

## Runtime in seconds is always changing

We've seen that the time it takes to run an algorithm depends on (1)
the "size" of the problem (e.g., in CatMatch more cats is a bigger
problem) and (2) how fast we can perform operations (e.g., how fast
`profile(cat)` and `similarity(profile1, profile2)` run).

For many years, CPU speeds reliably increased each year. What took 100
seconds in 1999 might take 10 seconds in 2000. This meant that a
single absolute measure of time could not capture how the algorithm
would perform as CPU speeds changed.

Moreover, the sizes of problems are constantly growing. Facebook
doesn't just care how fast code will run for 1 million users; they
want to know that as they grow to 100 million users there are no
obvious bottlenecks.

If we only cared about solving problems of a fixed, limited size, time
complexity would not be very important. The importance of
*scalability* is baked into our adoption of time complexity as a
measure of algorithm performance.

## Understanding time complexity helps us target optimizations

Time complexity helps us target our optimizations appropriately.

Say that I want to make CatMatch faster. I think of two optimizations:
(1) make Phase I 100x faster or (2) make Phase II 5% faster. Say that
both optimizations will take me an equal amount of effort to code up.
Which should I choose?

Optimization 1 sounds impressive, whereas optimization 2 sounds minor.
However, we know that for large numbers of cats, Phase II takes closer
and closer to 100% of the total time. That means Phase I takes closer
to 0% of the total time.

When we have 100,000 cats, we saw that Phase I takes 2% of the total
time. So a 100x improvement in Phase I will reduce the total runtime
by 1.8%. On the other hand, optimizing Phase II by 5% will result in a
savings of `(98% * 5%) = 4.9%` of total time.

As we have even more cats, the time savings of optimizing Phase I will
fall toward 0%, while the time savings of optimizing Phase II will
approach 5%.

Time complexity helps us understand that we should try to speed up
bottlenecks, not the already fast parts of our algorithms.

## Eliminating Bottlenecks

We've seen that time complexity helps us identify bottlenecks, which
we can target with optimizations. We can also try to eliminate them
entirely.

Recall that we want to find the most similar cats in CatMatch. To do
this, we compared every pair of cats.

If we think of our cat profiles as points in an multi-dimensional
space (one dimension per profile category), we might say that two cats
are the most similar if their profile-points are the closest pair in
the space. This problem is called the [closest pair of points
problem][closest-pair]. There is a very clever algorithm that, by
dividing up the space, can find the closest pair of points in
time proportional to `n*log_2(n)`.

In other words, we don't consider every pair of points. Let's consider
how phase II would improve:

Number of cats|`(n(n-1)/2) * 1`|`n*log_2(n) * 1`|Improvement
--------------|----------------|--------------|-----------
100           |4950            |664.39        |7.45x
1,000         |499,500         |9965.78       |50.12x
10,000        |49,995,000      |132,877.12    |376.25x

What we're seeing here is that since `n*log_2(n)` grows much more
slowly, the gap between the old way and the new way is increasing. The
new, faster way is a bigger and bigger improvement.

By changing the time complexity, we're getting a bigger and bigger
gain as the number of cats increases. This is better than a 10x, 100x,
or even 1,000x improvement; we've totally changed the time complexity.
The new algorithm will take closer and closer to 0% of the time of the
old algorithm, so long as we keep increasing the cats we're comparing.

[closest-pair]: http://en.wikipedia.org/wiki/Closest_pair_of_points_problem

## Resources

[Big-O Cheat Sheet][bigo]
[bigo]: http://bigocheatsheet.com/
