# W1D1
## Partner B interviews Partner A

### Chocolate Cake (30 mins)

You have a large square chocolate cake. Given an array of numbers of cuts you can make return the maximum number of pieces for each number of cuts. All pieces must be 1x1 squares.

### Solution
Try it out! figure out the math :)

```ruby
def maxChocolates(arr)
  arr.each do |num|
    if num.odd?
      puts ((num + 1) / 2) ** 2 - (num + 1) / 2
    else
      puts (num / 2) ** 2
    end
  end
end
```

### HTML5 (3 + 12 mins)

what is unique about html5?

### Solution

It has better storage options like localStorage and sessionStorage

Webworker that offloads expensive work

video and audio support

More?? Do some research together!
