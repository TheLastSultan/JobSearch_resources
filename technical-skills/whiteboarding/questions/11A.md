## Introduction

Walk me through your background.

(Assume you are applying to Coursera)

## Staying Current

How do you stay up to date on the latest libraries, languages, and technologies?

## `permutations`

Write a method that takes an array and returns all its
permutations. Time/memory complexity should be proportional to the
number of permutations; what is this?

Example:

```ruby
permutations([1,2,3])
=> [[1, 2, 3], [2, 1, 3], [2, 3, 1], [1, 3, 2], [3, 1, 2], [3, 2, 1]]

```

Bonus:

Write a class, `PermutationIterator`, that will iterate
through permutations of an array. It should use `O(n)` memory, and
return the "next" permutation in `O(1)` time. It can iterate through
permutations in whatever order you desire.

### Solution

```ruby
# O(n!)
def permutations(arr)
  return [[]] if arr.empty?

  perms = []
  arr.length.times do |i|
    # Choose an element to be first
    el = arr[i]
    rest = arr.take(i) + arr.drop(i + 1)

    # Find permutations of the rest, and tack the first `el` at front.
    new_perms = permutations(rest).map { |perm| perm.unshift(el) }
    perms.concat(new_perms)
  end

  perms
end
```

For an array of length `n`, there will be `O(n!)` permutations - the solution is `O(n!)` for both time and space complexity. We find permutations recursively, returning `[[]]`, the empty set of permutations, as our base case. We can then find the permutations of any array by iterating through the array, removing each element in turn (`arr.take(i) + arr.drop(i + 1)`) then finding the permutations of the remaining elements. We then unshift the removed element into each of those permutations.

## Truckin'

Given a fleet of 50 trucks, each with a full fuel tank and a range of
100 miles, how far can you deliver a payload? You can transfer the
payload from truck to truck, and you can transfer fuel from truck to
truck. Assume all the payload will fit in one truck.

### Solution

First, note that we have enough fuel for `50 * 100 == 5,000` truck
miles. Our problem is that we can't put all the fuel on a single
truck.

Instead, begin by driving all 50 trucks simultaneously. After two
miles, we will have burned `50 * 2 = 100` miles worth of fuel. This is
one trucks worth of fuel. Because we only have 49 trucks worth of fuel
left, it is unnecessary to drive all 50 trucks any more, because we
can fit all the fuel in 49 trucks.

Therefore, at the two mile mark, transfer all the fuel from one truck
to the other trucks. Leave an empty truck at the two mile mark. All
the other trucks are totally full of fuel.

Next, drive the remaining 49 trucks for `100/49` miles. After `100/49`
miles, we'll have burned another 100 miles worth of fuel, so we can
fit all the fuel in the remaining 48 trucks.

Continue like this until there is only one truck left, and it runs out
of fuel.

Let's calculate how many miles we can drive:

* 50 trucks of fuel: `100/50` miles
* 49 trucks of fuel: `100/49` miles
* 48 trucks of fuel: `100/48` miles
* ...
* 1 truck of fuel: `100/1` miles

Thus, you can then add up `100/50 + 100/49 + 100/48 + ... + 100/1`. This
is  ~449.9.
```
