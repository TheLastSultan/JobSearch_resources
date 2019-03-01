# W3D3

## Partner A Interviews Partner B

### Temperature Range (40 mins)

Given a range of temperatures ex [25,23,60,19,10,50,46]. Find the max temperature increase between any two days. It is not as simple as finding the min and max. The days had to be after one another, but not necessarily consecutive. If the temperature decreased return 0.

### Solution

Utilize the window pattern we studied earlier this week. Track lowest start as you move through the array. Also keep a record of the max range which you update whenever you find a new larger range.

Low progresses as such => 25, 23, 23, 19, 10, 10, 10

Max range progresses as such => 0, 0, 37, 37, 37, 40, 40

### Functional Programming (20 mins)
What is Functional Programming? Can you give me some code that shows the difference?

(If you struggle with this question, research it together and then answer again, live.)



```javascript
IMPERATIVE (NON-FUNCTIONAL)

function double (arr) {
  let results = []
  for (let i = 0; i < arr.length; i++){
    results.push(arr[i] * 2)
  }
  return results
}
2.

function add (arr) {
  let result = 0
  for (let i = 0; i < arr.length; i++){
    result += arr[i]
  }
  return result
}
3.

$("#btn").click(function() {
  $(this).toggleClass("highlight")
  $(this).text() === 'Add Highlight'
    ? $(this).text('Remove Highlight')
    : $(this).text('Add Highlight')
})
```


```javascript
DECLARATIVE (FUNCTIONAL)
1.

function double (arr) {
  return arr.map((item) => item * 2)
}

2.

function add (arr) {
  return arr.reduce((prev, current) => prev + current, 0)
}

3.

<Btn
onToggleHighlight={this.handleToggleHighlight}
highlight={this.state.highlight}>
{this.state.buttonText}
</Btn>
```
* [Imperative vs Declarative Programming](https://tylermcginnis.com/imperative-vs-declarative-programming/)
* [Imperative and (Functional) Declarative JS In Practice](http://www.redotheweb.com/2015/09/18/declarative-imperative-js.html)
* [Master the JavaScript Interview: What is Functional Programming?](https://medium.com/javascript-scene/master-the-javascript-interview-what-is-functional-programming-7f218c68b3a0)
