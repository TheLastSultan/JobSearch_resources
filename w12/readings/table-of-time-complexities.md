# Table of Common Time Complexities

| name         | big-oh         | tractability  | example |
| ------------ | -------------- | ------------- | ------------- |
| constant     | `O(1)`         | trivial       | hash maps |
| logarithmic  | `O(log(n))`    | simple        | binary search |
| linear       | `O(n)`         | typical       | linear scans |
| linearithmic | `O(n*log(n))`  | moderate      | sorting |
| quadratic    | `O(n**2)`      | tough         | pairing, doubly nested loops |
| exponential  | `O(2**n)`      | intractable   | subsets |
| factorial    | `O(n!)`        | intractable   | subsequences |

Most of the time, when you have twice as much work to do, it takes you
twice as long to do the work. Take, for instance, adding up a list of
numbers. Twice as many numbers means twice as many numbers to add; it
should take twice as long to add them all. That seems fair; this is
called a **linear** problem.

Some tasks get harder and harder. Imagine a set of 5 switches where
only one combination of settings (on/off) will activate a
circuit. There are `2**5` settings. Each time we add an additional
switch, there are twice as many settings to check. This problem
becomes harder and harder as we add additional switches. This is
called an **exponential** problem; these are some of the worst kind of
problems.

Other problems have economies of scale where we can solve much bigger
problems with just a little more work. Consider a problem where we
would like to implement a spell-checker; we need to store a dictionary
set, but we also need to balance the comprehensiveness of the
dictionary with the time it will take to lookup a word.

Let's use a tree set. If we want to limit ourselves to making 10
comparisons, we can store a dictionary of `2**10 = 1024` words. At the
cost of one additional comparison, we could double the size of the
dictionary (1024 new words). And an additional comparison after that
doubles the size again (another 2048 words). The cost of adding a new
word to the dictionary is going down as the dictionary gets bigger.

This is a very desirable kind of problem; it is called
**logarithmic**.

These are our first three **complexity classes**: logarithmic, linear,
and exponential. We'll see a few others soon.
