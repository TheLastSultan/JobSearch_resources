# W1D5
## Pair Programming

### Next-largest Node (45 mins)
Consider a BST.

0) Write a BSTNode class, nodes should not hold references to parents

1) Given the root node and a current node, find the node in the BST that has the next-largest value compared to the current node.

### Hashes! (15 mins)
Explain how accessing values in a hash is done in constant time...explain what's going on in memory, etc.


### Spellcheck (40 mins)
Write a spellcheck function that takes in an invalid word as a string and returns an array of suggested words. You have access to a dictionary set so checking the validity of a string is in constant time.

For starters, assume you have a one character typo. You can build upon this for optimization.

Additional assumption: we could keep a cache of frequently typed incorrect strings and their corresponding correct words, but let's assume this is a new spellcheck feature so we can't implement this yet.

What other human-based optimizations might our code take account of?

### Selectors (5 mins)
For the following HTML, write a one line CSS selector that selects only Apple and Banana.
```html
<ul>
  <li></li>
  <li></li>
  <li></li>
  <ul>
    <li>Apple</li>
    <li>Orange</li>
    <li>Banana</li>
  </ul>
</ul>
```
