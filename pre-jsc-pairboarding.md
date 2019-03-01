### Week 2

## Partner A: `digital_root`

Write a method, `digital_root(num)`. It should sum the digits of a
positive integer. If it is greater than or equal to 10, sum the digits of the
resulting number. Keep repeating until there is only one digit in the
result, called the "digital root". Do not use string conversion within
your method.

**Hint 1:** modular arithmetic is very useful.

**Hint 2:** in Ruby, integer division yields an integer.  E.g., 7/3 = 2.

**Hint 3:** what kind of loop is useful when you're relying on a logical condition, rather than a number of iterations?

### Solution

There are two common approaches to this problem: iterative and recursive.  First, let's go for the iterative approach.  Logically, we're doing two steps:

1. Iterate over the digits of the given number, summing them as we go,
2. Check if our sum is greater than or equal to 10, and repeat Step 1 if it is.

We'll delegate Step 1 to a helper method, `#digital_root_step`. Step 2 will take place in our "real" method.  Notice that what we're really doing is nesting one `while` loop inside of another.  Here's Step 2:

```ruby
def digital_root(num)
  sum_so_far = num 
  
  # Check if our sum is less than 10
  while sum_so_far >= 10
    # Sum the digits of our sum so far 
    sum_so_far = digital_root_step(num)
  end

  # Return the sum only after we've achieved a sum less than 10
  sum_so_far
end
```
And here is Step 1.  We use modular arithmetic to get the value of the ones digit, then divide by 10 to "erase" that digit.  We sum as we go:

```ruby
def digital_root_step(num)
  root = 0
  while num > 0
    root += (num % 10)

    num /= 10
  end

  root
end
```
The recursive solution is very similar, although it looks different at first.  As with all recursive methods, we define our base case, and our recursive step:

**Base case**: the `num` passed in is less than 10.
**Recursive step**: add the `ones_digit` to the "rest" of the number: e.g., `ones_digit + num/10`, and call the method recursively on this sum.

The base case is serving the purpose of the `num >= 10` check on the outer `while` loop in the iterative solution.  The rest of the work is condensed into that single, recursive call on `ones_digit + num/10`.  

```ruby
def digital_root_recur num
  return num if num < 10
  digital_root_recur((num % 10) + (num / 10))
end

```
### Time Complexity 

Let's examine the iterative solutuion.  The time complexity of this method is a bit tricky.  Recall that we have one loop nested inside another, which may make you think *quadratic!*, but don't be fooled.  Remember *why* nested loops often result in quadratic time complexity:

```ruby 
n.times do |i| 
   n.times do |j| 
      puts i*j
   end
end
```

It's because we run the inner line of code `n` times, and running all of that `n` times, so our time complexity is <i>n</i>*<i>n</i> = <i>n</i><sup>2</sup> -- so really, we should be thinking about *multiplying* the number of times the outer `while` loop runs by the number of times the inner loop runs.

The inner loop is easier.  This will run once for every digit in our `num`.  To make this more exact, we can think of `num` as bounded by two powers of 10.  We then take <i>log</i><sub>10</sub> of both sides.

10<sup><i>n</i></sup> < `num` < 10<sup><i>n</i>+1</sup>
=> <i>n</i> < <i>log</i><sub>10</sub> `num` < <i>n</i>+1

So, the inner loop runs in approximately <i>log</i> `num` time.

What about the outer loop?  That one is trickier still.  Mathematically, it's hard to evaluate for a given `num` how many times this loop will run.  We can find an upper bound, which happens to be <i>log</i><sub>10</sub> <i>n</i> as well.  The mathematics behind why this bound holds is beyond the scope of this course, and beyond what you'll be expected to know in interviews, so we'll leave it at that.  

Since both the outer and inner loops have time complexity <i>log n</i>, the time complexity of `digital_root` is <i>log</i><sup>2</sup> <i>n</i>.  


## `caesar_cipher`

Write a function that takes a message and an increment amount and
outputs the same letters shifted by that amount in the
alphabet. Assume lowercase and no punctuation. Preserve spaces.

### Solution

The most time-efficient way to approach this problem is to create a dictionary of letters using a structure that makes it easy and fast to access a letter at any position in the alphabet.  An *array* will do this for us -- arrays allow us to access a value at any index in constant time.  (This is not the case for all data structures.  For example, consider a <a href="https://en.wikipedia.org/wiki/Linked_list">linked list</a>.)  

```ruby
def caesar_cipher(str, shift)
  letters = ("a".."z").to_a

  encoded_str = ""
  str.each_char do |char|
    if char == " "
      encoded_str << " "
      next
    end

    old_idx = letters.find_index(char)
    new_idx = (old_idx + shift) % letters.count

    encoded_str << letters[new_idx]
  end

  encoded_str
end
```

### Week 3
### Week 4
### Week 5
### Week 6
### Week 7
### Week 8
