# W1D1
## Partner A interviews Partner B

### Zig-zag Tree (30 mins)
Given a node, Iterate through a (not-full) binary tree in a "zig-zag" pattern, i.e. at level 0 go from right to left, at level 1 go from left to right, at level 2 go from right to left, etc. Print value at each node.

### Solution
The key here is to have two arrays so that you can process all the elements from one and hold their children in the other.

```ruby
def zig_zag (root)
  level = 0
  # this is the array that will hold the next elements we
  # will need to process
  next_children = [root]
  until next_children.empty?
    # this is the array we will print from
    level_arr = []
    # moving elements over to be processed
    until next_children.empty?
      level_arr << next_children.shift
    end
    # putting their children in storage
    level_arr.each { |el| next_children += el.children }
    # processing the level according to depth
    until level_arr.empty?
      method = level.even? ? :pop : :shift
      p level_arr.send(method).value
    end
    level += 1
  end
end

```

### CSS (3 + 12 mins)

Given some HTML,
```HTML

<div>
  <section>
    <div></div>
  </section>
  <div></div>
</div>
<div></div>
```
How would you select the last element?

### Solution

div + div (sibling selector)

Are there other ways? Do some extra research together!
