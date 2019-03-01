### Warmup Solution

If we sort the intervals by their start value, then each set of intervals that can be merged will appear as a contiguous "run" in the sorted list. After sorting, we insert the first interval into our merged list and continue considering each interval in turn as follows: If the current interval begins after the previous interval ends, then they do not overlap and we can append the current interval to merged. Otherwise, they do overlap, and we merge them by updating the end of the previous interval if it is less than the end of the current interval.

```ruby
def merge_intervals(array)
  array.sort!
  merged = []

  array.each do |pair|
    if merged.empty? || merged[-1][1] < pair[0]
      merged << pair
    else
      merged[-1][1] = pair.last
    end
  end

  merged
end
```

Credit: [Leetcode](https://leetcode.com/problems/merge-intervals/description/)

### Challenge 1 Solution

```ruby
class Array

  # This method is exactly the same.
  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    # To reduce probability of pathologically bad data set, shuffle pivot.
    new_pivot = start + rand(length)
    array[start], array[new_pivot] = array[new_pivot], array[start]

    pivot_idx = start
    pivot = array[start]

    ((start + 1)...(start + length)).each do |idx|
      if prc.call(pivot, array[idx]) > 0
        array[idx], array[pivot_idx + 1] = array[pivot_idx + 1], array[idx]
        pivot_idx += 1
      end
    end
    array[start], array[pivot_idx] = array[pivot_idx], array[start]
    pivot_idx
  end

  def select_kth_smallest(k)
    left = 0
    right = self.length - 1
    loop do
      return self[left] if left == right
      pivot_idx = Array.partition(self, left, right-left+1)
      if k-1 == pivot_idx
        return self[k-1]
      elsif k-1 < pivot_idx
        right = pivot_idx - 1
      else
        left = pivot_idx + 1
      end
    end
  end
end
```

#### Time Complexity
First let's review why QuickSort is `O(nlogn)`

* We consider each element the number of times it takes to reach a single element by recursively splitting our set in half(ish).

* `n` elements times `logn` ---> `O(nlogn)`

So, why is QuickSelect `O(n)`?

* Take note that each time we cut our set in half, we already know the part in which our desired element lies, based on the size of the partitions.
* Thus, each time we consider fewer and fewer elements. How many?
* The first time we consider `n` elements.
* Then, `n/2`, `n/4`...`1`
* Adding these all together, we get something called a Geometric Series, since `1, 1/2, 1/4...` can be seen as increasing powers of `1/2`
* The sum of an convergent infinite geometric series (where the multiplicative factor, `r` is less than 1) can be found with the formula `a/(1-r)`, where a is the first term.
* Without being fully rigorous about the variations of partition size, we can nevertheless see that if `r = 1/2` this comes out to `2n`, and since our series is not in fact infinite, `O(QuickSelect) < 2n ~ n`

### Challenge 2 Solution:

We can solve this problem in ```O(n logM)``` time by using a heap! We construct a min heap of size M and insert the first element of each list into it. Then, we pop the root element from the heap and insert the next element from the same list as the popped element. We repeat this process until the heap is exhausted.

NB: The code for this solution is fairly straightforward, so I have not included a solution in Ruby. If you have a great implementation, feel free to open a pull request! 🤗
