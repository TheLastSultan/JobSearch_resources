# Arrays

Arrays are one of the first data structures that you utilized in your App Academy education, and they'll continue to be a powerful tool throughout your career.  You'll use arrays extensively during the interview process, so it's important to know how to use them and how fast their built-in operations take in your preferred language(s).

## C vs. Ruby  

You're likely most comfortable programming in Ruby.  That's by design; Ruby is a readable, user-friendly language with a lot of built-in functionality.  However, Ruby is actually a wrapper for a different language: **C**.  C, in turn, is a wrapper for an even lower level language called *assembly language*.  We'll get more into that in a later, optional project.  For now, what's important to know is that there several key trade-offs that are made between Ruby and C:

- Ruby suffers from slower runtimes than equivalent C code, but Ruby does not need to be compiled and is extremely easy to learn and fast to write
- Ruby offers a lot of built-in functionality on top of its data structures, whereas C operates on a "no hidden mechanism" principle -- C doesn't mask what's actually going on behind the scenes

A key example of the *no hidden mechanism* principle is the difference in how C and Ruby handle arrays.  

## Arrays in C

In C, arrays work a little bit differently than they do in Ruby.  The key difference is that arrays in C are a fixed size from the time they are constructed.  You as the programmer must specify that size.  Why?  Well, because C must allocate contiguous memory in which the array will be stored, and it cannot allocate an arbitrarily large amount of memory for the array -- that would be impractical.  Think of an array in C like this:

![](https://assets.aaonline.io/fullstack/job-search/algorithms/arrays/diagrams/array_in_C.png)

Because its size is fixed, an array such as this is referred to as a **static array**.

Now let's discuss the key functionality of this array: `#find`, `#push`, and `#delete`.  What will be the time complexity of each of these operations?  Let's assume that `arr.find(i)` retrieves the `i`th element in the array. Since C stores the location in memory of the array itself, finding the `i`th element is just a matter of arithmetic: if the array starts at position `M` in memory, then the `i`th element can be found at position `M + i`.  Both arithmetic and lookup at a specific location in memory are constant time operations, so `#find` runs in constant time as well.

Similarly, `#push` will also run in constant time.  This is because C stores not just the location of the array in memory, but also the current length of the array.  Hence, if we want to perform `arr.push("new value")`, we find the next available space in `arr` with pointer arithmetic again: the memory location `M + length` will be assigned `"new value"`.  Again, both the arithmetic and the assignment are constant time operations, so `#push` takes constant time.

Finally, what about `#delete`?  This one is a bit harder.  Imagine that `arr = ['a', 'b', 'c', 'd']` and we perform `arr.delete('b')`.  We cannot simply unassign `'b'` from its space in memory, as that would leave a gap in our contiguously assigned memory allocation:

![](https://assets.aaonline.io/fullstack/job-search/algorithms/arrays/diagrams/bad_deletion.png)

In addition (or instead of) unassigning `'b'`'s memory location, we must also *copy over* all of the elements that come after `'b'`, thus keeping the memory allocation contiguous:

![](https://assets.aaonline.io/fullstack/job-search/algorithms/arrays/diagrams/copying_over.png)

On average, we'll do `n/2` copying operations when we delete an item from our array, and we'll do `n - 1` in the worst case. So `#delete` runs in `O(n)` time in both the average and worst cases.

Now that we know how our basic operations run on a static array, we ask an obvious next question: how do arrays in Ruby work?  That is, how is it that we're able to keep pushing onto an array in Ruby ad nauseam, and we never have to specify how long our array needs to be?  The answer to both questions is that we use our static arrays to build something better: a dynamic array.

## Dynamic Arrays

Imagine that we want to modify our static array so that it can accommodate as many items as we want to put into it.  How would we do it?  Remember, a static array takes up a fixed amount of memory, so we cannot simply allocate "enough" memory to suit an arbitrarily large array.  Instead, what we will have to do is *change* the memory allocation when our current amount of memory falls short of our needs.  In practice, this means that whenever we reallocate, we'll have to move our entire array to another position in memory, as shown here:

![](https://assets.aaonline.io/fullstack/job-search/algorithms/arrays/diagrams/new_allocation.png)

As you can see, this process takes `O(n)` time for an array of size `n`, since we must copy over each of the `n` elements and deallocate each of the `n` original memory locations.  Hence, we must be careful; we do not want to reallocate too often, as that could drastically increase the amount of time needed for the most basic operations.  

You can probably think of a few potential approaches to this problem.  Perhaps we could add one space only when we need it; perhaps we could add 100.  Take a moment to formulate an idea or two for how *you* might approach this problem.  After we detail our approach, go back and ask yourself if any of your ideas would have resulted in the same (or better!) time complexity for our basic functionality.  

The approach we will use is this: each time we find ourselves in a situation where our allocated space is too small, we will *double* the current size of the array, reallocate memory, and copy over the elements currently stored in the array.  As an example, imagine that we create a static array of size 4.  We allocate a large enough space in memory and push in elements <i>a</i><sub>1</sub>, <i>a</i><sub>2</sub>, <i>a</i><sub>3</sub>, and <i>a</i><sub>4</sub>:

![](https://assets.aaonline.io/fullstack/job-search/algorithms/arrays/diagrams/filled_array.png)

We have now filled our array, so when we push in <i>a</i><sub>5</sub>, we find a new space in memory that is twice the original allocated size.  We then copy over all 4 original items and push in <i>a</i><sub>5</sub>.  Finally, we free up the old memory allocation so that it can be used elsewhere:

![](https://assets.aaonline.io/fullstack/job-search/algorithms/arrays/diagrams/double_allocation.png)

This is the essence of our newly created data structure: the **dynamic array**.  *Dynamic* refers to the fact that our array resizes dynamically based on the available space.  Clearly, `#find` still runs in constant time, and `#delete` still runs in `O(n)` time.  What about `#push`?  In the worst case, `#push` will run in `O(n)` time, since we will have to copy over all `n` elements in our array to their new location in memory.  However, this is a situation in which we are more concerned with the *average* case; our array size increases in a predictable way, from length 1 to 2 to 3 and so on.  Hence, the average case will give us the best picture of how this operation will perform as our array grows.  (Compare this to the worst case for a sort, say quicksort: why is the worst case more of a concern there?)

To deduce the time complexity in the average case, let us assume that we create an array of size *k*.  When we push item <i>a</i><sub>1</sub>, it takes constant time, as will pushes 2, 3, 4, ... , *k*.  (We will distill "constant time" down to simply 1 unit of time.  Recall that this may actually take more than 1 unit of time, but the important part is that each of these pushes will take the *same* amount of time).  However, push *k* + 1 takes linear time to perform, since at this point the array must double in size.  From here, pushes *k* + 2, *k* + 3, ... 2<i>k</i> will take 1 unit of time each to perform.  Once we get to push 2<i>k></i> + 1, our array must again double in size, so we use 2<i>k</i> + 1 time to do this single push.  Here's a chart summarizing this work:

![](https://assets.aaonline.io/fullstack/job-search/algorithms/arrays/diagrams/time_chart.png)

To find the average, or *amortized*, time complexity, we think of each unit of time as a square block.  Here's how our chart above looks if we use our block visualization:

![](https://assets.aaonline.io/fullstack/job-search/algorithms/arrays/diagrams/block1.png)

Now, let's rearrange these blocks.  For clarity, we've colored the blocks in the constant time cases blue, and those in the linear cases green.  We'll *redistribute* the green blocks in the following way:

![](https://assets.aaonline.io/fullstack/job-search/algorithms/arrays/diagrams/block2.png)

Hence, we can now imagine that cases 1, 2, ... *k*, *k* + 2, *k* + 3, ... 2<i>k</i>, 2<i>k</i> + 2, 2<i>k</i> + 3, ... each take 2 units of time instead of 1, and that cases *k* + 1, 2<i>k</i> + 1, ... take 0 units of time.  Each case now takes *constant time* to perform, and thus on average, `#push` runs in `O(1)` time.

This is good news.  It means that if we build our dynamic array in this way, each of our fundamental operations, `#find`, `#push`, and `#delete`, will take the same amount of time on average that they do on our static array. Ruby's array object is exactly this: a dynamic array written in C wrapped in a straightforward, simple Ruby API.

## Another Improvement: Ring Buffer

We've now determined that the time complexities of `#push(item)` and `#find(index)` are both `O(1)`, and `#delete(index)` is `O(n)`.  What about `#unshift`?  Ideally, we would like this operation to be `O(1)`, just as `#push` is. But the way we've currently set up our dynamic array in memory does not allow for this; there is extra space at the end of the array, but not at the beginning, which means that if we were to `#unshift('z')`, we'd have to copy every element in the existing array over by one space in memory.  

![](https://assets.aaonline.io/fullstack/job-search/algorithms/arrays/diagrams/unshift.png)

This would take `O(n)` time.  To fix this, we'll use another data structure called a *ring buffer*.  The way a ring buffer works is to think of the array as circular, rather than linear:

![](https://assets.aaonline.io/fullstack/job-search/algorithms/arrays/diagrams/ring_buffer1.png)

Notice that now, if we were to `unshift('z')`, we have the space to do it.  We simply use the space at the *end* of the allocated space in memory.

How, specifically, would we implement such a thing?  What do we need to keep track of?  Our previous implementation of the dynamic array kept track of the length of the stored data as well as its location in memory and capacity.  Here, we need to keep track of only one more thing: the *start* location, that is, the memory location of `arr[0]`.  

Spend a couple minutes brainstorming how you would implement a ring buffer's key functionality: `#find(index)`, `#unshift(item)`, `#push(item)`, and `#delete(item)`.  How would the implementation of these methods differ from the comparable methods in the dynamic array?  


## Time Complexity of the Built-Ins

In our final section, we'll review some of the built-in array methods in Ruby that you'll find useful during interviews.  A common stumbling block in evaluating time complexity lies within these built-ins.  They can be easy to overlook and, if you haven't spent some time thinking them through, easy to forget their time complexities.  It's not strictly necessary that you use the extensive library of Ruby built-ins during an interview, but if you do, you should know the time complexity of whatever you're using.  You should also be able to explain *why* a particular time complexity is what it is.  

We'll discuss the time complexity of one of the most commonly used built-ins (beyond `#[]`, `#delete`, and `#push`): `#inject`.  This will give you a template for evaluating the time complexity of other built-ins.  

Recall that the `#inject` function takes in a block and an initial object, and accumulates an object to return by successively applying that block to every element in the array.  To evaluate the time complexity of `#inject`, let's think about how we would write this function by hand: we'd iterate through the array and apply the block as we go:

``` ruby

def myInject(arr, obj, &block)
  ans = obj

  arr.each do |el|
    ans = block.call(ans, el)
  end

  ans
end

```

The `each` loop runs *n* times, where `arr.length` is *n*.  That means that our block runs *n* times, so the time complexity of `myInject` depends on the time complexity of `block`.  In particular, `O(myInject) = O(n)*O(block)`.  For example, suppose that we find ourselves in a situation where `block` runs in constant time, the simplest possible case; perhaps `block = { |a, b| a + b }`.  Then `O(myInject) = O(n)*O(1) = O(n)`.  

Things can get more complicated, though.  Suppose that we run `myInject` on an array of arrays, and that `block = { |a, b| b.each do |el| { a << el } }`.  Now, `O(block.call(a, b)) = O(b.length)`, so if each *element* of our original array is itself an array of, say, size *k*, then `O(myInject) = O(n)*O(k) = O(nk)`.  

To make things even more complicated, suppose that each element of our original array is an array whose size is equal to its index.  Then instead of simply multiplying `O(n)*O(block)`, we must *add* the time complexities of each run through our inner loop, i.e., `O(myInject) = O(0) + O(1) + O(2) + ... + O(n - 1) = O(n)*(O(0) + O(1) + ... + O(n - 1)) = O(n(n - 1)/2) = O(n^2)`.  

Don't forget to evaluate time complexity as part of the project you'll be doing shortly!  

## Your Turn

Now that you know how arrays work in a variety of languages, it's time to do some implementation.  Phase 1 will have you implement a dynamic array using a static array.  In Phase 2, you'll use your new data structure to implement some of the basic array functionality as well as coding up some answers to common interview questions on arrays.
