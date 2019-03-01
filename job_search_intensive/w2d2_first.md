# W2D2

## Pair Programming

### Prototype (15 mins)
What is the ""prototype"" in JavaScript?

What is the difference between defining something on the prototype versus defining it in the constructor function?

### Output (15 mins)
```javascript
var testFunc = function testFunc(test) {
  if (test) {
    var a = 4;
  }
  console.log(a)
}
testFunc(true);
```

1) Can you explain to me what this code does? Line by line?
2) What is the output of the last line?
3) Tell me what hoisting is.
4) Can you explain how hoisting works with the JavaScript interpreter?

5) What happens if I change testFunc(true) to testFunc()
6) What is undefined in JavaScript?
7) What is truthy and falsey?
8) How will this code get evaluated in the interpreter?

9) What happens if I change var a = 4; to const a = 4; ?"

### Store a Tree (90 mins)
Store an poly-ary tree using sql such that I can find all the children of a given node with A SINGLE QUERY!

Start a Rails project, design and migrate your schema and write routes and a controller action for storing new nodes and accessing lists of children in Rails.

Note: the result is a list of children nodes, not a subtree.

What if we wanted to insert a node in between a node and its parent? How would your code handle this?




**Zip up your work and email to amaciver@appacademy.io**
