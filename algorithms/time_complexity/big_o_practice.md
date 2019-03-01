# Time Complexity Workshop

Today we're going to practice analyzing a few functions' time complexities. This is a unique topic; you'll have to be able to conjure the time complexity of your code on the spot in interviews, and you'll be expected to do so without the benefit of Googling the basics (like "What is a logarithm?"). 

1. Explain this as clearly as possible to your partner. Take good notes 
on how you're answering each question. The more detailed your answers, the better you'll be able to compare them to the solutions.
2. Open up the [solutions][solutions]. After you solve each problem, switch 
over to the solutions to make sure you and your partner got it right and to
be sure that you understand before moving on! Don't look ahead in the solutions!
3. The partner sitting on the left is now **Partner A**, and on the right sits **Partner B**.

Notice also that we are somewhat language agnostic in this assignment -- that't intentional. Some of the subtler time complexity points do depend upon what language you're using, but for the most part the language won't matter for the big stuff. There are some exceptions, but for today, assume language doesn't matter.

Sally forth!  

### Arrays Are Awesome

Let's start with some array manipulation to get us warmed up. Find the time complexity of each of the following functions (in order -- they depend on each other). You may assume that all arrays are arrays of integers, for convenience. When you evaluate time complexity, remember to do each of the following:

1. Specify which aspect (or aspects) of the input the time complexity depends on. E.g., if a function is `O(n)`, what is *n*?
2. Explain thoroughly and clearly *why* the time complexity is what it is.
3. Find the *worst* cases. 
3. Discuss space complexity too: this is usually deemphasized over time complexity, but some interviewers will ask about it.

**NB**: you can assume that any print statements (`console.log`, `puts`, etc.) run in constant time. We'll come back to this near the end, but this is also a safe assumption to make in interviews.

So, what's the time complexity of this function? Remember to find those constant factors as well as the overall time complexity, especially for these simple examples. **Partner A**, explain this one to **Partner B**.

1.
```ruby
def add(a, b)
  if a > b
    return a + b
  end

  a - b
end

```
Ok, now move onto this one. It's **Partner B**'s turn to explain:  

2.
```ruby
def print_arr_1(arr)
  arr.each do |idx|
    puts idx
  end
end
```
Great, two easy ones out of the way! Now, what happens when we add just one more line? What changes, and what stays the same? (Don't forget about those constant factors!)

**NB**: alternate who does the explaining for the rest of the Warm-Ups.

3.
```ruby
def print_arr_2(arr)
  arr.each_with_index do |el, idx|
    break if idx == arr.length/2 - 1
    puts el
  end
end
```
Let's make another change, again asking ourselves how the time complexity is affected. 

4.
```ruby
def print_arr_3(arr)
  arr.each do |el|
    break if el == arr.length/2 - 1
    puts el
  end
end
```
Finally, let's add a little bit to our code. 

5.
```ruby
def print_arr_4(arr)
  arr.each do |el|
    break if el == arr.length/2 - 1
    puts el
  end

  arr.each_with_index do |el, idx|
    puts el if idx % 3 == 0
  end

  puts arr.last
end
```
Now let's make a bigger change.  Define a basic `search` function as follows:

6.
```ruby
def search(arr, target)
  arr.each_with_index do |el, idx|
    return idx if el == target
  end
end
```
Now, let's use this `search` within another function.  Determine the time complexity of the following:

7.
```ruby
def searchity_search(arr, target)
  results = []
  arr.each do |el|
    results << search(arr, target + el)
  end

  results  
end
```
You may have noted that the *nested* nature of `search` within the loop of this function affects this drastically. But not all loops are created equal. Think carefully about this one:

8.
```ruby
def searchity_search_2(arr, target)
  results = []
  arr.each do |el|
    results << search(arr, el)
  end

  results  
end
```


### Interacting with Iterativeness

Let's leave the arrays behind for a bit, and look at a few other functions. Start with **Partner A** explaining the time complexity of this one:

1.
```javascript
let iterative_1 = (n, m) => {
  let notes = ["do", "rei", "mi", "fa", "so", "la", "ti", "do"];

  for (var i = 0; i < n; i++) {
    for (var j = 0; j < m; j++) {
      let position = (i+j) % 8;
      console.log(notes[position]);
    }
  }
}
```
How do things change when we make this subtle alteration?

2.
```javascript
let iterative_2 = (n) => {
  let notes = ["do", "rei", "mi", "fa", "so", "la", "ti", "do"];

  for (var i = 0; i < n; i++) {
    for (var j = i; j >= 0; j--) {
      let position = (i+j) % 8;
      console.log(notes[position]);
    }
  }
}
```
Now, let's combine both ideas. What's the time complexity of this function?

3.
```javascript
let iterative_3 = (n, m) => {
  let notes = ["do", "rei", "mi", "fa", "so", "la", "ti", "do"];

  let bigger = n > m ? n : m;
  let smaller = n <= m ? n : m;

  for (var i = 0; i < smaller; i++) {
    for (var j = i; j < bigger; j++) {
      let position = (i+j) % 8;
      console.log(notes[position]);
    }
  }
}
```

### Radical Recursion

Recursive functions are among the toughest to evaluate for time complexity. Remember **FFS**:

1. <b>F</b>ind the time complexity of *one call*, ignoring the recursive calls,
2. <b>F</b>ind the number of times the function is called, and, if necessary, the input sizes on all of those calls.
3. <b>S</b>um everything together.

Let's start with something nice and simple. Don't forget to find the constant factor! (As a bonus, figure out a better name for this function than `rec_mystery` -- what is it doing?)

4.
```ruby
def rec_mystery(n)
  return n if n < 5

  rec_mystery(n - 5)
end
```
Let's change things ever so slightly.  Now what is the time complexity?

5.
```ruby
def rec_mystery_2(n)
  return 0 if n == 0

  rec_mystery_2(n/5) + 1
end
```

Now let's add in a bit of complexity with some extra variables in the mix.

6.
```java
void rec_mystery_3(int n, int m, int o)
{
  if (n <= 0)
  {
    printf("%d, %d\n", m, o);
  }
  else
  {
    rec_mystery_3(n-1, m+1, o);
    rec_mystery_3(n-1, m, o+1);
  }
}
```

The next one is a bit harder. If you're stumped, feel free to take a look
at the solution, and then come back and try to explain in your own words.

7.
```ruby
class Array
  def grab_bag
    return [[]] if empty?
    bag = take(count - 1).grab_bag
    bag.concat(bag.map { |handful| handful + [last] })
  end
end
```

At this point, look over your notes and answers to make sure you understand how you've solved each question. 

Well done! If you finished early, go ahead and start watching the 
[Video Lectures](https://github.com/appacademy/sf-job-search-curriculum/blob/master/w12/day1.md#afternoon) on Arrays that you'll need for the project tonight.

[solutions]: ./big_o_solutions.md


