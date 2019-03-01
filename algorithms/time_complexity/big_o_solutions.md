# Time Complexity Practice: Solutions

## Arrays are Awesome

1. `add`: Constant. All the operations (comparison, addition, and subtraction) are in constant time.

2. `print_arr_1`: Linear. The each loop will go through every element in the input array and perform a constant operation on every element (`puts`). Each additional element in the array results in another iteration.

3. `print_arr_2`: Linear. `each_with_index` will iterate through half of the elements (n/2). Factor out the '/2' to get a linear time complexity. All the operations inside the loop are constant (see [here](http://batsov.com/articles/2014/02/17/the-elements-of-style-in-ruby-number-13-length-vs-size-vs-count/) for an explanation about Array#length).

4. `print_arr_3`:
 * Best case: constant. If the element we're looking for is the first one in the array, it'll meet the break condition and exit immediately.
 * Worst case: linear. The loop will iterate through every element in the array if the element we're looking for is the last one or not present in the array at all.

5. `print_arr_4` (with constants!)
 * Best case: n + 2. The first loop could break on the first element, but the `each_with_index` loop will run through the whole array no matter what. Array#last is constant.
 * Worst case: 2n + 1. Both loops could iterate through every element in the array. Array#last is still constant.

6. `search`
 * Best case: Constant. If the element that matches the target is the first element in the array, it will immediately finish the search.
 * Worst case: Linear. If the element never equals the target, it will iterate through the entire array.

7. `searchity_search`
 * Best case: Linear. If the array is all the same elements and the target is 0, the inner loop will run in constant time because it'll immediately find the first element. We still have to loop `n` times through the outer loop.
 * Worst case: Quadratic. If `target + el` doesn't exist in the array, both the inner and outer loops will go through the entire length of the array.

8. `searchity_search_2`: (n(n + 1))/2. Therefore, if you remove all of the constant factors, it would 
still be (n)^2.


### `iterative_1`

The functions `iterative_1`, `iterative_2`, and `iterative_3` all use nested loops, but with some subtle differences amongst the three functions. Let's start by taking a look at `iterative_1`.

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
The two lines within the inner loop run in constant time:

```javascript
let position = (i+j) % 8;
console.log(notes[position]);
```
So, we only need to figure out how many times this piece of code runs. The inner loop runs *m* times, from *j* = 0 to *j* = *m* - 1. If this loop ran on its own, it would run in O(*m*) time. However, the *outer loop* runs the *inner loop*, and it does so *n* times, from *i* = 0 to *i* = *n* - 1. Hence, the total number of times the two lines of code above run is *nm*, so this function runs in O(*nm*) time.

### `iterative_2`

Next, let's look at `iterative_2`.

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

Once again, the two lines housed within the inner loop run in constant time, so we need only determine how many times those two lines run. The key difference between this difference and `iterative_1` is that the number of times the inner loop runs depends upon which iteration of the outer loop we're currently on. So our tactic here will be a little different: instead of simply multiplying, we'll count up the number of iterations of the inner loop for *each* value of *i*. Take a look at the table below:

![](https://assets.aaonline.io/fullstack/job-search/algorithms/time_complexity/iter_table_1.png)

To obtain the total number of times the two lines inside the inner loop run, we'll simply add together the righthand column.

*number of calls* = 1 + 2 + 3 + ... + (*n* - 1) + *n*
=> *number of calls* = *n*(*n* + 1)/2

This is a quadratic expression, so the time complexity of `iterative_2` is O(<i>n</i><sup>2</sup>).

### `iterative_3`

Finally, here's `iterative_3`:

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

This time, our loops iterate to different bounds *and* the inner loop varies in size. Since the inner loop's size varies, we'll use the same strategy that we did with `iterative_2` and count the total number of times the code inside the inner loop runs as *i* varies. For brevity, assume *n* > *m*, so *n* = *bigger* and *m* = *smaller*.

![](https://assets.aaonline.io/fullstack/job-search/algorithms/time_complexity/iter_table_2.png)

This table looks similar to the one we saw with the previous problem. But sadly, we aren't summing *all* the integers from 1 to *n* in the righthand column -- only those from *n - m* + 1 to *n* -- so we can't use the identity we used for `iterative_2` -- or *can* we??? Take a look at this table, which includes some extra values of *i*, colored red (all lines where *i* is bigger than *m* - 1).

![](https://assets.aaonline.io/fullstack/job-search/algorithms/time_complexity/iter_table_3.png)

Now we'll use the summation identity, but we'll do it twice: we'll add together red and black entries in the table, then subtract off the red entries.

*number of calls* = *all table entries* - *red table entries*

=> *number of calls* = (1 + 2 + 3 + ... + (*n* - 1) + *n*) - (1 + 2 + 3 + ... + (*n* - *m* - 2) + (*n* - *m* - 1))

=> *number of calls* = *n*(*n* + 1)/2 - (*n* - *m* - 1)(*n* - *m*)/2

To make the algebra a little easier, we'll multiply each side by 2. Then, we'll foil out the multiplication and do some cancelling.

2 x *num of calls* = *n*(*n* + 1) - (*n* - *m* - 1)(*n* - *m*)

=> 2 x *num of calls* = *n*<sup>2</sup> + *n* - (*n*<sup>2</sup> - *nm* - *nm* + *m*<sup>2</sup> - *n* + *m*)

=> 2 x *num of calls* = 2<i>nm</i> - *m*<sup>2</sup> + 2n - *m*

The fastest-growing term on the righthand side is 2<i>nm</i>. Since *n* > *m*, this term grows faster than *m*<sup>2</sup>. Hence, `iterative_3` runs in O(*nm*) time.

### `rec_mystery`

Remember that with a recursive function, the procedure for figuring out the time complexity is:

1. Evaluate the time complexity of one pass through the function, *ignoring the recursive calls*.
2. Evaluate how many recursive calls are made, and what the individual time complexities of those calls are.
  - If the time complexity of *one pass* is constant, then it's enough to find the number of recursive calls that are made. All the time complexities of these calls will be constant.
  - Remember that if one pass through the function is *not* constant, then the input that you give to the recursive call may change its time complexity (e.g., if a function takes in an array and you pass only part of that array to a recursive call, then your time complexity will depend on how large that part of the array is)
3. Add together all the recursive calls with their respective time complexities. **NB**: in the case where one pass is constant, the number of calls is *equal to* the total time complexity (why?).

With that in mind, recall the function that we're asked to find the time complexity of:

```ruby
def rec_mystery(n)
  return n if n < 5

  rec_mystery(n - 5)
end
```
One pass through this function is clearly a constant time operation. Yay! That means we simply need to find the number of recursive calls that we're making. The diagram below represents those calls. For the sake of simplicity, we'll assume that *n* mod 5 = 2 and thus eventually reaches 2, but this assumption doesn't change our underlying analysis.

*n* &rarr; *n* - 5 &rarr; *n* - 10 &rarr; ... &rarr; 2

How many calls have we made? Let's work backward. We start at 0, and add 5 until we reach *n*. The number of 5's in our sum is equal to the number of recursive calls being made.

2 + 5 + 5 + 5 + ... + 5 = *n*

=> 2 + 5 x (*number of calls*) = *n*

=> *number of calls* = (*n* - 2)/5

The number of calls is (*n* - 2)/5, and thus `rec_mystery` runs in O(*n*) time.

### `rec_mystery_2`

The mathematics behind this function is slightly trickier, but not much. The idea behind our analysis is exactly the same as in `rec_mystery`. Recall the code:

```ruby
def rec_mystery_2(n)
  return 0 if n == 0

  rec_mystery_2(n/5) + 1
end
```
Once again, one pass through this function takes constant time, so we only need to find the number of recursive calls being made. As before, let's draw a diagram of those calls. Here, we assume that *n* is a power of 5, just so that we get down to exactly 1. This makes our arithmetic explanation nicer, but keep in mind that the same analysis would apply even if we didn't have a power of 5.

*n* -> *n*/5 -> *n*/5<sup>2</sup> -> *n*/5<sup>3</sup> -> ... -> 1

Again, let's work backwards. Since we are dividing by 5 on each call until we reach 1, we'll multiply to work our way back up the chain to *n*:

1 &rarr; 5 &rarr; 5<sup>2</sup> &rarr; 5<sup>3</sup> &rarr; ... &rarr; *n*/5<sup>2</sup> &rarr; *n*/5 &rarr; *n*

Translate this into a mathematical equation, as we did before:

1 x 5 x 5 x 5 x ... x 5 = *n*

=> 5<sup>*number of calls*</sup> = *n*

=> *number of calls* = log<sub>5</sub> *n*

The number of calls is log<sub>5</sub> *n*, and so the time complexity is O(log<sub>5</sub> *n*) or O(log *n*). (Note that the base of a logarithm (or an exponent) doesn't matter when we're talking about time complexity. Not writing a base implies base 10, usually.)

### `rec_mystery_3`

This function looks harder than our previous two, but it's actually easier to decipher than it looks. Recall the code:

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
**NB**: interviewers will sometimes have you to read or parse code in a language that's unfamiliar to you, which i why we've included a couple such examples in this assignment!

This function takes in three inputs instead of one: *n*, *m*, and *o*. Don't let that deter you! Let's approach it just as we did the previous two problems. One pass through this function runs in constant time -- we do a check to see how large *n* is, and then we add or subtract from our inputs (*n* - 1, *m* + 1, etc.) before making our two recursive calls (which we ignore, for now).

So, that leaves us to figure out how many recursive calls are being made. Let's draw a tree:

![](https://assets.aaonline.io/fullstack/job-search/algorithms/time_complexity/call_tree.png)

As we can see, this looks a lot like our call tree for the Fibonacci numbers -- there are just more variables there. Level *k* from the top does 2<sup><i>k</i></sup> calls, which was exactly the case with `#fibonacci` as well.

One other key observation, however, is that this call tree will terminate when *n* = 0. That's important -- it means that not just each level, but the total *number* of levels, is determined only by *n*. This tree will terminate at level *n*, when the input in *n*'s place is equal to 0. Hence, as with `fibonacci`, we get:

*number of calls* = 1 + 2 + 4 + ... + 2<sup><i>n</i> - 1</sup> + 2<sup><i>n</i></sup>

=> *number of calls* = 2<sup><i>n</i> + 1</sup> - 1

So, `rec_mystery_3` runs in O(2<sup><i>n</i></sup>) time.

### `grab_bag`

Now this is where our recursion gets a little crazy. Recall our `grab_bag` code:  

```ruby
class Array
  def grab_bag
    return [[]] if empty?
    bag = take(count - 1).grab_bag
    bag.concat(bag.map { |handful| handful + [last] })
  end
end
```
This example is a great place to use bounding. To do so, it's helpful to first know what this code does. In words, this function creates all possible "grab bags" of the first *n* - 1 elements in our array (that's what the `take(count - 1).grab_bag` does). Then, it takes that big set of grab bags and adds a bunch more grab bags: it takes each grab bag and adds the array's last element onto it. The grab bags containing the last element get combined with the grab bags that *don't* contain the last element, and the whole set of those grab bags gets returned.

The key here is that this function differentiates between whether an element (namely, `last`) is *in* or *out*. That's exactly how a *subset* is formed. For each element `el` in the original array, we decide whether to include or not include `el`. In other words, this function is returning the set of all subsets of elements in the array.

This way of defining subsets (*in* and *out* elements) also gives us a clue as to what the lower bound on our time complexity must be. There are 2<sup><i>n</i></sup> subsets of an array of size *n*, since we have exactly 2 choices for each of the *n* elements: *in* or *out*. Hence, we're producing an array (the set of subsets) that is exponentially large in comparison to the input, so our time complexity will be at least O(2<sup><i>n</i></sup>).

To show that the time complexity is *exactly* O(2<sup><i>n</i></sup>), we will use a technique called mathematical induction. This is a somewhat advanced topic that you're not expected to know coming into the course, but the basic idea of induction is as follows:

1. Prove that the base cases run in the expected time complexity (exponential with respect to their small input sizes).
2. Assume that `grab_bag` runs in O(2<sup><i>n - 1</i></sup>) for an array of size *n* - 1. Use this assumption to prove that this function runs in 2<sup><i>n</i></sup> time on an array of size *n*.

We won't go into detail about why mathematical induction is a valid proof technique, but the idea is that we're creating a logical chain, starting at the base case, and proving the time complexity for each link in that chain. More details can be found on Wikipedia.

In Step 1, we simply observe that for the base case, an array of size 0, `grab_bag` simply does one comparison and returns.

Now, for Step 2, we will assume that `grab_bag` runs in 2<sup><i>n - 1</i></sup> time for an array of size *n* - 1. That means that the line `bag = take(count - 1).grab_bag` takes 2<sup><i>n - 1</i></sup> time to run. Additionally, `bag` has *size* 2<sup><i>n - 1</i></sup>. This is important, because the next line iterates through `bag` and performs a constant time operation on each bag, so the iterator also takes 2<sup><i>n - 1</i></sup> time to run. Finally, we concatenate each of these 2<sup><i>n - 1</i></sup> items onto `bag`. So, we have three operations running in O(2<sup><i>n - 1</i></sup>) time, which means that `grab_bag` runs in O(3*2<sup><i>n - 1</i></sup>) = O(1.5*2<sup><i>n</i></sup>) = O(2<sup><i>n</i></sup>)
time as well.
