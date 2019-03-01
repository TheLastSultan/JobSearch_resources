## Sorting Challenges

### Warm Up: Merge Intervals
Given a collection of intervals, merge all overlapping intervals.

#### Example 1:
```
Input: [[1, 3], [2, 6], [8, 10], [15, 18]]
Output: [[1, 6], [8, 10], [15, 18]]
Explanation: Since intervals [1, 3] and [2, 6] overlap, merge them into [1, 6].
```

#### Example 2:
```
Input: [[1, 4], [4, 5]]
Output: [[1, 5]]
```

### Challenge 1: QuickSelect
Write an in-place instance method on the Array class that will find the ```kth``` smallest element in ```O(n)``` time. You will likely want to use a partition method similar to if not exactly the same as that which you used for QuickSort! For a bonus, how can we eliminate any extra space cost?

NB: 1st smallest is the 0-th element in a sorted array.

#### Example

```ruby
[1, 5, 7, 4, 3, 2, 8, 9].select_kth_smallest(2) => 2
```

### Challenge 2: Merge M Sorted Lists
Given M sorted lists of variable length, print them in sorted order efficiently. You must do so in O(n log M) time.

#### Example
```
Given the following lists:

[10, 20, 30, 40]
[15, 25, 35]
[27, 29, 37, 48, 93]
[32, 33]

The output is:

[10, 15, 20, 25, 27, 29, 30, 32, 33, 35, 37, 40, 48, 93]
```

#### Hint
We could create an array containing all elements of all lists then sort it. However, this would result in a worst case time complexity of ```O(n logn)```, where ```n``` is the total number of elements in all lists. This approach does not take advantage of the fact the lists are already sorted. Given our time complexity constraints, what kind of data structure could we use to make sure we are always inserting the minimum element from our sorted array? Perhaps one that we learned about yesterday? 🤔

### [Solutions](https://github.com/appacademy/sf-job-search-curriculum/blob/master/supplemental_problems/sorting_solution.md)
