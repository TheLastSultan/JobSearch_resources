## Find the Median from a Data Stream

The median is the middle number in an ordered array of integers. If the length of the array is even, there is no middle value, so the median is the average of the two middle numbers.

```ruby
median([1, 2, 3, 4, 5]) => 3
median([1, 2, 3, 4]) => (2 + 3) / 2 => 2.5
```

You are designing a data structure that accepts an incoming data stream of integers. Write an API for your data structure which supports the following operations:

* ```add()``` accepts an integer from the stream and adds it to your data structure
* ```find_median()``` returns the median of all elements which have been added from the stream so far

### Example

```ruby
add(8)
find_median() => 8
add(16)
find_median() => 12
add(4)
find_median() => 8
```

### Requirements:

* ```O(log n)``` time complexity for insertion
* ```O(1)``` lookup for the median value
* ```O(n)``` maximum space to store the dataset

### Hints:

* You could store incoming elements in an array, sort it after each insertion, and index into the middle of the array to find the median. However, this exceeds our time limit.
* You could use insertion sort to maintain a sorted list. However, insertion would take ```O(nlog n)``` time, which also exceeds our limit.
* If only there were a data structure with ```log n``` insertion which allowed us to look up its maximum or minimum value in constant time...

### [Solution](./find_median_from_data_stream_solution.md)
