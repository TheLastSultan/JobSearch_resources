# Event Propagation

Previously, we learned about [event handling][event-handling]. Let's go a little more in depth and take a look at how events propagate.

## The Bubbling Principle

Consider the following:

```html
<div class="outer">
  <div class="middle">
    <div class="inner">
      I am in the innermost div!
    </div>
  </div>
</div>

<script>
  const outerDiv = document.querySelector('.outer');
  outerDiv.addEventListener('click', function (e) {
    alert('CLICKED!');
  });
</script>
```

In the above code, we set a click handler on the outermost `div`. Somehow, the handler gets triggered even when we click on the content in the innermost `div`. Why does this happen? The answer is that DOM events bubble.

**The Bubbling Principle:** After an event triggers on the deepest possible element, it then triggers on its parents in nesting order.

By this principle, the `click` event first triggers on the innermost `div`, then bubbles up to the middle `div`, then finally triggers on the outer `div` which has a handler registered on it.

## Target Review

A quick review on `event.target`: the deepest element which triggered the event is called the `target`. In the above example, this would be the inner `div`. `target` remains constant throughout the bubbling process.

`event.currentTarget`, on the other hand, is the element on which the handler is registered. In the event listener in our above code, the `currentTarget` is the outer div.

```javascript

outerDiv.addEventListener('click', function (e) {
  console.log(e.target); // the inner div
  console.log(e.currentTarget); // the outer div
});

```

## Multiple Listeners

Let's alter the above code slightly to add multiple listeners.

```html
<div class="outer">
  <div class="middle">
    <div class="inner">
      I am in the inner-most div!
    </div>
  </div>
</div>

<script>
  const outerDiv = document.querySelector('.outer');
  outerDiv.addEventListener('click', function (e) {
    alert('outer');
  });

  const middleDiv = document.querySelector('.middle');
  middleDiv.addEventListener('click', function (e) {
    alert('middle');
  });

  const innerDiv = document.querySelector('.inner');
  innerDiv.addEventListener('click', function (e) {
    alert('inner');
  });
</script>
```

Say we click on the innermost `div`. What happens?

By the bubbling principle, we trigger the innermost `div`'s handler first, then trigger the middle `div`'s handler, then finally trigger the outer `div`'s handler. We see all three alerts in the order "inner", "middle", "outer".

## Stopping Propagation

Say we want to stop an event's propagation. How would we do so?

Very simply, in our event handler, we can call `event.stopPropagation()` to stop the event from bubbling further.
Let's look at the above code one more time, stopping the event when we reach the middle div's handler.

```html
<div class="outer">
  <div class="middle">
    <div class="inner">
      I am in the inner-most div!
    </div>
  </div>
</div>

<script>
  const outerDiv = document.querySelector('.outer');
  outerDiv.addEventListener('click', function (e) {
    alert('outer');
  });

  const middleDiv = document.querySelector('.middle');
  middleDiv.addEventListener('click', function (e) {
    alert('middle');
    e.stopPropagation();
  });

  const innerDiv = document.querySelector('.inner');
  innerDiv.addEventListener('click', function (e) {
    alert('inner');
  });
</script>
```

Now, when we click on the innermost div, we will see the alerts "inner" and "middle", but because we have halted the event's propagation, we will never see the "outer" alert.


[event-handling]: https://github.com/appacademy/curriculum/blob/master/javascript/readings/document-object-model.md#events
