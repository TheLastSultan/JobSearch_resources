# W2D1

## Partner A Interviews Partner B

### Maximum Depth (20 mins)
How would you calculate the maximum depth of nested ul/ol's in a DOM

Example: depth of 3
```html
<ul>
  <li></li>
  <li>
    <ul>
      <li></li>
    </ul>
  </li>
  <li>
    <ul>
      <li>
        <ul>
          <li></li> <!-- I am the deepest -->
        </ul>
      </li>
    </ul>
  </li>
</ul>
```

### Solution
Using jQuery: find all `li`s that don't have `ul`s use `parents` method to track the depth of each of these.

```javascript
// create maxDepth and cDepth variables
var maxDepth = -1
  , cDepth   = -1
  ;

// each `li` that hasn't `ul` children
$("li:not(:has(ul))").each(function() {

    // get the current `li` depth
    cDepth = $(this).parents("ul").length;

    // it's greater than maxDepth found yet
    if (cDepth > maxDepth) {

       // this will become the max one
       maxDepth = cDepth;
    }
});
```

Using VanillaJS:
```javascript
let list = document.querySelectorAll('li');
let maxDepth = 0;
let curDepth = 0;
let terminus = document.body;
list.forEach( (node) => {
  thisNode = node;
  let parent = null;
  while (parent !== terminus) {
    parent = thisNode.parentNode;
    if (thisNode.tagName == 'LI') { curDepth++ }
    if (curDepth > maxDepth) { maxDepth = curDepth }
    thisNode = parent;
  }
  curDepth = 0;

})
console.log(maxDepth);
```

### Substring
Given two strings a and b, where b may or may not be a substring of a, determine at what index of a, b starts. Return -1 if b is not a substring of a.

### Solution (20 mins)
Naive Solution:
```ruby
def index_of_substring(a, b)
  (0...a.length - b.length + 1).each do |i| # O(n)
    (0...b.length).each do |j| # O(m)
      break unless a[i + j] == b[j]
    end

    return i
  end

  -1
end
```
We can do better! how could this be improved to linear (or sub-linear!) time??
