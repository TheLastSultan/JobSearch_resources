# W2D4

## Partner A Interviews Partner B

### Sign Here (10 mins)
var p = new Person('Bob');
p.logName();

1) Can you write me the code to create the function logName and log the person's name to the console?
2) Please write it in both ES5 and ES6

### Solution
Aw, come on, you can work this out :) Do it together!


### Minimum Valid Edits (45 mins)
Given two strings as input, find the minimum number of edits to string1 in order to turn it into string2, such that each word along the way has to be verified as a real word via API call. You cannot use a word in your traversal if it is not a real word as determined by the API call.

If you need help with methods and syntax ask you interviewer!

### Solution
BFS problem. Queue for processing, Hash to ensure we don't include words we've already seen. Take a word from the front of the queue. Generate new options by changing every letter of the word (`O(25k)`) one at a time, check if the new word is a real word, and put it in the queue if it hasn't been seen before. Also include information attached to each word indicating the depth at which it was found. How would we reconstruct the list rather than simply determine the number of steps?

```javascript

//npm init -y
//npm install --save fs word-list

//npm package that will let us query if a word exists; you would actually be using an external API

const fs = require('fs');
const wordListPath = require('word-list');
const wordArray = fs.readFileSync(wordListPath, 'utf8').split('\n');
const wordsObj = {};
//optimizing lookup by storing in an object
for (const key of wordArray) {
    wordsObj[key] = true;
}


const minimumEdits = (str1, str2) => {
  let queue = []
  let visited = {}
  let entry, str, chars, thisChar, tempChars, newWord, i, j, result
  queue.push([str1, 0])
  while (queue.length > 0) {
    entry = queue.shift()
    str = entry[0]
    chars = str.split('')
    tempChars = chars.slice()
    i = 0
    while (i < chars.length) {
      j = 0
      thisChar = 'a'
      while (j < 26) {
        if (chars[i] !== thisChar) {
          tempChars[i] = String.fromCharCode(thisChar.charCodeAt(0))
          thisChar = String.fromCharCode(thisChar.charCodeAt(0) + 1)
          newWord = tempChars.join('')
          if (newWord === str2) {
            console.log(`success: ${newWord}, steps: ${entry[1] + 1}`);
            result = entry[1] + 1
            return result
          } else if (wordsObj[newWord]) { // This would be where the API call would happen, async issues? How to solve?
            if (!visited[newWord]) {
              visited[newWord] = true
              console.log(newWord);
              queue.push([newWord, entry[1] + 1])
            }
          }
        } else {
          thisChar = String.fromCharCode(thisChar.charCodeAt(0) + 1)
        }
        j++
      }
      tempChars[i] = chars[i]
      i++
    }
  }
  return console.log("No path found");
}

minimumEdits('bread', 'clear')
```
