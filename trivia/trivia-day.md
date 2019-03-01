

# Technical Trivia

Technical trivia is a huge part of the interview process.  Both phone screens and on-sites can include a round or rounds of technical trivia. Making sure you are comfortable with the the trivia environment, the questions themselves, and how to answer them is invaluable in your job search.

### Strategy:

Whenever we are answering technical questions, we should always keep the following in mind:

* **Simple and concise answers:** There's no need to go in depth.  Try to keep your answers to one sentence.  If the interviewer wants you to go more into depth, they will ask you to.
* **Examples:** In some cases, a single sentence isn't enough, or perhaps your understanding of a concept isn't 100%.  In those cases use an example of whatever the answer is to the question, but try to keep the example in as few sentences as possible as well.
* **Be honest:** Do not try to answer if you know you do not have the answer. Dead air when you are grasping for an answer (especially over the phone) is never helpful. State confidently that you are not familiar with the answer and let the process continue.
* **KEEP STUDYING!** At the end of the day, the only sure fire way to get better is to keep studying.  We can never know all the answers, but we can always learn more.

## Instructions:

For today's technical trivia event:

* Groups of three will ask one another trivia in three rounds.
* for each round:
  * One person will ask the questions
  * One person will answer the questions
  * One person will be score keeper, keeping track of how many answers are correct. Correct answers are at the score keeper's discretion.
  * Answerers will have a maximum of 8 minutes to answer as many questions as they can. The person asking the questions will monitor time.
* After the first three rounds, the participants from each group with the highest score will take turns answering trivia Spelling-Bee style while the moderator asks them questions one by one.  
* If a player cannot answer their question or answers incorrectly they will be disqualified.  If there are only two participants left, and a participant cannot answer their question, the same question will be asked to the other participant.  If neither can answer the question, both will stay in the game and a new question will be asked.
* Questions are asked until a winner is declared.
* Questions are different for each round and will vary in difficulty.


***_NB_**: _This is just a sample of some common technical trivia questions. The reality is there's no knowing what trivia might be asked, so it's important to maintain your study habits on practical coding._   

## Round One

_click on the question to navigate to its' answer.  Click on the "back to" link from the answer to return to the questions_

* [Why do you need doctype?](#why-do-you-need-doctype)
* [What is the use of data-* attribute?](#what-is-the-use-of-the-data--attribute)
* [What is createDocumentFragment?](#document-fragment)
* [What does float do?](#what-does-float-do)
* [Are CSS properties case sensitive?](#are-css-properties-case-sensitive)

* [What is position static?](#what-is-position-static)

* [Is there implicit function return in JavaScript?](#implicit-return-in-javascript)

* [What are 5 of the 7 "falsey" values in JavaScript?](#what-are-the-7-falsey-values-in-javascript)

* [What is a primitive datatype in Javascript?](#what-is-a-primitive-datatype-in-javascript)
* [Consider the following expression: `var y = 1, x = y = typeof x`. What will be the value of x?](#value-of-x)
* [If `const a = 2, b = 3` what would be value of `a && b`?](#a-and-b)
* [Does the following code throw a reference error? Why/Why not?](#why-does-the-following-code-work)

```js
sayHello(); // OUTPUT: "Hello";

function sayHello() {
  return "Hello";
}
```
* [Is null an object?](#is-null-an-object)
* [Are `let` and `const` hoisted?](#are-let-and-const-hoisted)
* [Briefly describe the concept of memoization](#briefly-describe-the-concept-of-memoization)



## Round Two

_click on the question to navigate to its' answer.  Click on the "back to" link from the answer to return to the questions_

* [How can you change the direction of html text?](#how-can-you-change-the-direction-of-html-text)
* [How do you highlight text in html?](#how-can-you-highlight-text-in-html)
* [Which of these executes first: ```document.onload``` or ```window.onload``` ?](#which-of-these-executes-first)
* [Does margin-top or margin-bottom effect inline elements?](#does-margin-top-or-margin-bottom-effect-inline-elements)
* [What is position relative?](#what-is-position-relative)
* [Name three pseudo selectors](#name-three-pseudo-selectors)
* [Name all six primitive data-types in Javascript](#name-all-six-primitive-data-types-in-javascript)
* [What is the difference between `null` and `undefined`?](#what-is-the-difference-between-null-and-undefined)
* [What is the value of `this` inside of a `setTimeout` function?](#what-is-the-value-of-this-inside-of-a-settimeout-function)
* [What is the Value of `this` inside of a constructor function?](#what-is-the-value-of-this-inside-of-a-constructor-function)
* [What is the Temporal Dead Zone?](#what-is-the-temporal-dead-zone)
* [Can you directly compare two objects in Javascript?](#can-you-directly-compare-two-objects-in-javascript)
* [What does the bind method do?](#what-does-bind-do)
* [What is the difference between window and document?](#what-is-the-difference-between-window-and-document)
* [What are two-way data binding and one-way data flow, and how are they different?](#data-binding)


## Round Three

_click on the question to navigate to its' answer.  Click on the "back to" link from the answer to return to the questions_

* [Will the browser make an http request for the following case?](#will-the-browser-make-an-http-request-for-the-following-case)
  ```HTML
  <img src="mypic.jpg" style="visibility: hidden" alt="My photo">
  ```
* [Is style1.css downloaded before Paragraph 1 is rendered?](#does-style1css-have-to-be-downloaded-before-paragraph-1-is-rendered)
```HTML
<head>
    <link href="style1.css" rel="stylesheet">
</head>
<body>
    <p>Paragraph 1</p>
    <p>Paragraph 2</p>
    <link href="style2.css" rel="stylesheet">
</body>
```
* [What is an optional closing tag?](#what-is-an-optional-closing-tag)
* [Does padding-top or padding-bottom effect inline elements?](#does-padding-top-or-padding-bottom-effect-inline-elements)

* [What is position absolute?](#what-is-position-absolute)

* [List css specificity rules from most specific to least specific](#list-css-specificity-rules-from-most-specific-to-least-specific)
* [Explain variable hoisting](#explain-variable-hoisting)
* [Does javascript pass parameter by value or by reference?](#does-javascript-pass-parameter-by-value-or-by-reference)
* [In what order will the numbers 1-4 be logged to the console when the code below is executed? Why?](#event-loop)

```js
function counter() {
    console.log(1);
    setTimeout(() => console.log(2), 1000);
    setTimeout(() => console.log(3), 0);
    console.log(4);
}

counter();
```
* [What are the three phases of event propagation?](#what-are-the-three-phases-of-event-propagation)
* [Is javascript compiled or interpreted?](#is-javascript-compiled-or-interpreted)
* [What does the global object refer to in JavaScript?](#what-does-the-global-object-refer-to-in-javascript)
* [What does the `length` property of the JavaScript Function object return?](#what-does-length)
* [When inspecting a MouseEvent object, which of the following do target and currentTarget represent?](#current-target)
* [What is a prototype in JavaScript?](#what-is-a-prototype-in-javascript)

=====

## Answers

##### Why do you need doctype?

* Doctype is an instruction to the browser to inform about the version of the html document and how browser should render it.
[Back to Round One qs](#round-one)

##### What is the use of the data-* attribute?

* It allows you to store extra information/ data in the DOM. You can write valid html with embedded private data. You can easily access the data attribute by using javascript and hence a lot of libraries like knockout use it.
[Back to Round One qs](#round-one)

##### <a name='document-fragment'></a> What is createDocumentFragment?

* createDocumentFragment is like a mini DOM you can append elements to in order to avoid costly insertions. Once you've appended elements to the fragment, you can append the fragment to a node element and the fragment itself will disappear.

[Back to Round One qs](#round-one)

##### What does float do?

*  Float removes the element from the normal flow of the document and pushes the element to the sides of the page with text wrapping around it.

[Back to Round One qs](#round-one)

##### Are CSS properties case sensitive?

* No

[Back to Round One qs](#round-one)

##### What is position static?

* The default position value for an html element.  Not relative, absolute, fixed, or sticky.

[Back to Round One qs](#round-one)

##### Implicit return in JavaScript

* Yes, via one line big arrow functions or big arrow functions that wrap their block in parentheses.  

[Back to Round One qs](#round-one)

##### How can you apply css rules specific to media/screen-size?

* Use @media to set rules based on media width, orientation, etc. Example:
```CSS
@media (max-width: 700px) and (orientation: landscape){}
```

[Back to Round One qs](#round-one)

##### What are the 7 falsey values in javascript?

* `0`, `""`, `NaN`, `-0`, `null`, `undefined`, `false`

[Back to Round One qs](#round-one)

##### What is a primitive datatype in Javascript?

* A primitive datatype is not an object, is **immutable**, and has no attributes/methods defined directly on it

[Back to Round One qs](#round-one)

##### <a name='value-of-x'></a> Consider the following expression: `var y = 1, x = y = typeof x`. What will be the value of x?

* `undefined`

[Back to Round One qs](#round-one)

##### <a name='a-and-b'></a> If `const a = 2, b = 3`, what would be the value of `a && b`?
* 3

[Back to Round One qs](#round-one)

##### Why does the following code work?
* Because named functions are hoisted and can be used before their declaration

[Back to Round One qs](#round-one)

##### Is `null` an object?
* No. Even though `typeof null` returns `object`, this is a bug. You can not put any attributes on null, as it is a `primitive` datatype.

[Back to Round One qs](#round-one)

##### Are let and const hoisted?
* Yes

[Back to Round One qs](#round-one)

##### Briefly describe the concept of memoization
* Memoization is a programming technique which attempts to increase a function’s performance by caching its previously computed results. POJO's are often used to implement these caches.

[Back to Round One qs](#round-one)



=====

##### How can you change the direction of html text?

* use bdo (bidirectional override) element of html.
```html
<p><bdo dir="rtl">This text will go right to left.</bdo></p>
```
 [Back to Round Two qs](#round-two)

##### How can you highlight text in html?

* Use mark element.
```html
<p>Some part of this paragraph is <mark>highlighted</mark> by using mark element.</p>
```

[Back to Round Two qs](#round-two)

##### Which of these executes first

* ```document.onload``` executes first

[Back to Round Two qs](#round-two)

##### Does margin-top or margin-bottom effect inline elements?

* No

[Back to Round Two qs](#round-two)

##### What is position relative?

* The computed position of the element where it can be spaced in relation to its' normal position in the flow of the document using ```top```, ```bottom```, ```left```, and ```right```

[Back to Round Two qs](#round-two)

##### Name three pseudo selectors:

* :hover, :nth-of-type, :visited, :focus, :link, :first, :child, :checked, :last-child, :target, etc.

[Back to Round Two qs](#round-two)


##### Name all six primitive data-types in Javascript:

* boolean, string, number, null, undefined, and symbol (ES6 only)

[Back to Round Two qs](#round-two)

##### What is the difference between `null` and `undefined`?

* Undefined means the value of a variable is not defined. JS has a global variable called `undefined` whose value is `undefined`.
* `null` means empty or non-existent value which is used by programmers to indicate “no value”. Must be explicitly assigned.

[Back to Round Two qs](#round-two)

##### What is the Value of `this` inside of a setTimeout function?

* The window

[Back to Round Two qs](#round-two)

##### What is the Value of `this` inside of a constructor function?

* A newly created object

[Back to Round Two qs](#round-two)

##### What is the Value of `this` inside of a constructor function?

* A newly created object

[Back to Round Two qs](#round-two)

##### What is the Temporal Dead Zone?

* This has to do with the topic of hoisting. The temporal deadzone is the time between entering a scope where a variable is declared (i.e. an `if` statement or `while` loop), and the actual declaration and initialization of that variable. During this period, `let` and `const` variables cannot be accessed (you will get a `Reference Error`), even though they have been hoisted. Example:

```js
console.log('out of scope');

if (true) {
  // Enter temporal deadzone. `x` is created and hoisted as soon as we enter scope.
  console.log('In the scope!');  // TEMPORAL DEADZONE
  // TEMPORAL DEADZONE
  let x = "Test Variable"; // No longer in the temporal deadzone
}
```

[Back to Round Two qs](#round-two)

##### What is the Temporal Dead Zone?

* This has to do with the topic of hoisting. The temporal deadzone is the time between entering a scope where a variable is declared (i.e. an `if` statement or `while` loop), and the actual declaration and initialization of that variable. During this period, `let` and `const` variables cannot be accessed, even though they have been hoisted.

[Back to Round Two qs](#round-two)

##### Can you directly compare two objects in Javascript

* No.

[Back to Round Two qs](#round-two)

##### What does bind do?

* The bind method creates a _new_ function that, when called, has its `this` keyword set to the first parameter passed into it. All subsequent parameters are arguments for that bound function.

[Back to Round Two qs](#round-two)

##### What is the difference between window and document?

* JavaScript has a global object and everything runs under it. `window` is that global object that holds global variables, global functions, location, history everything is under it. `document` is also under window. document is a property of the window object. document represents the DOM and DOM is the object oriented representation of the html markup you have written

[Back to Round Two qs](#round-two)

##### <a name='data-binding'></a> What are two-way data binding and one-way data flow, and how are they different?

* This a tough-y 😎. Here's the deal: **Two-way data binding** means that UI fields are bound to model data dynamically. I.e., when a UI field changes, the model data changes with it and vice-versa. An example of this is Angular.js, which uses two-way binding. **One way data flow** means that the model is the **single source of truth**. A change in UI is not _directly_ bound to the model. An example of a one-way data flow framework is React. Only the model, or `store` in this case, has access to the application's state.  

[Back to Round Two qs](#round-two)


=====

##### Will the browser make an http request for the following case?

* Yes!

[Back to Round Three qs](#round-three)

##### <a name='#does-style1css-have-to-be-downloaded-before-paragraph-1-is-rendered'></a>Does style1.css have to be downloaded before Paragraph 1 is rendered?

* Yes!

[Back to Round Three qs](#round-three)

##### What is an optional closing tag?

* p, li, td, tr, th, html, body, etc. do not have to provide an end tag. However, you have to escape the tag.
```HTML
<p>Some text
<p>Some more text
<ul>
 <li>A list item
 <li>Another list item
</ul>
```
is read as:
```HTML
<p>Some text</p>
<p>Some more text</p>
<ul>
 <li>A list item</li>
 <li>Another list item</li>
</ul>
```

[Back to Round Three qs](#round-three)

##### Does padding-top or padding-bottom effect inline elements?

* No

[Back to Round Three qs](#round-three)

##### What is position absolute?

* The computed position of the element where it can be spaced after being removed to from the normal flow of the document.  It is spaced in relation to its' first non-static parent container with `top`, `bottom`, `left`, and `right`.

[Back to Round Three qs](#round-three)

##### List css specificity rules from most specific to least specific:

* inline, ID, class, element, universal (4 out of 5 is acceptable)

[Back to Round Three qs](#round-three)

##### Explain variable hoisting:

* At a broad level, hoisting is the concept of having access to named functions and variables (only `var`s) before they are declared in your code. This works because variable and function declarations are put into memory during the compile phase.

[Back to Round Three qs](#round-three)

##### Does javascript pass parameter by value or by reference?

* It depends on the datatype. Primitive types (string, number, etc.) are passed by value and objects are passed by reference. If you change a property of the passed object, the object will be affected.

[Back to Round Three qs](#round-three)

##### <a name='event-loop'></a> In what order with the numbers 1-4 be logged to the console when the code below is executed? Why?

* `1, 4, 3, 2`. 1 and 4 come first because they are logged without delay. 3 comes before 2 because it has a shorter asynchronous delay. Even though `3` has a delay of `0`, it is still placed on the event queue while the browser is busy. You can think of a `setTimeout` of `0` as meaning "as soon as possible".

[Back to Round Three qs](#round-three)

##### What are the three phases of event propagation?

* 1. Capturing phase: Events begin at the top level and move inwards towards the target (the node you clicked)
  2. Target node: If there are registered handlers at the target node, they are run.
  3. Bubbling phase: Event walks back outwards towards root; all encountered event handlers are run on the way.

[Back to Round Three qs](#round-three)

##### Is Javascript compiled or interpreted?

* Interpreted.

[Back to Round Three qs](#round-three)

##### What does the global object refer to in JavaScript?

* A POJO that exists to provide all built-in methods and global variables.

[Back to Round Three qs](#round-three)

##### <a name='what-does-length'></a> What does the "length" property of the JavaScript Function object return?

* The number of arguments taken by the function (not including rest parameters)

[Back to Round Three qs](#round-three)

##### <a name='current-target'></a> When inspecting a MouseEvent object, which of the following do `target` and `currentTarget` represent?

* `currentTarget`: the element the listener is set on, `target`: the element the mouse is on.

[Back to Round Three qs](#round-three)

##### What are the proper keywords for error handling in JavaScript?

* "try...catch"

[Back to Round Three qs](#round-three)

##### What is a prototype in JavaScript?

* An object.

[Back to Round Three qs](#round-three)
