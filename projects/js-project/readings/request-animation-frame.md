# `window.requestAnimationFrame`

## The Game Loop

Every animated game needs a game loop - we need to account for user interaction and move stuff around on the screen. A simple game loop could look something like this:

```JavaScript
setInterval(function() {
    // Animate stuff
}, 1000/60) // 60 frames per second (kinda)
```

What's wrong with this? Well, for one thing, in order for animations to be smooth the browser often has to paint frames more rapidly than the screen can display them. This causes extra, unecessary computation to take place and sometimes causes 'skips' or lag in the animation. Additionally, even if our user switches to a different tab, our game loop will continue to run.

## Enter requestAnimationFrame

This window method fixes both of our problems - it prevents frame skipping by optimizing for browser speed, and pauses the animation when a user switches tabs. We use it like this:

```JavaScript
function gameLoop() {
    // Animate stuff
    requestAnimationFrame(gameLoop)
}
```

We call our game loop once the game is set up and the DOM has loaded to kick things off. If we want to pause our animation, we can call a method called `cancelAnimationFrame`. First, you'll need to know that `requestAnimationFrame` returns an ID we can use to manipulate it later. Let's capture the ID and cancel the animation frame when the user clicks on the page:

```JavaScript
const body = document.getElementsByTagName('body')[0];
let id;

function gameLoop() {
    // Animate stuff
    id = requestAnimationFrame(gameLoop)
}

body.addEventListener('click', () => {
    cancelAnimationFrame(id)
})
```

If we later call `requestAnimationFrame(id)`, our animation will pick up where it left off.

## Controlling the Animation Speed

When building a JavaScript game, many students have difficulty controlling the speed of their game loop. The game will speed up and slow down, and will run at different speeds on different computers. If your game loop is just recursively calling itself, it makes sense that these differences occur - your computer might be doing other work, and different computers or browsers may execute the code faster. How can we account for this obvious difficulty?

Let's refer back to the [Asteroids](https://github.com/appacademy/curriculum/tree/master/javascript/projects/asteroids/class_syntax_solution) project we worked on earlier in the curriculum.

Take a few minutes and re-familiarize yourself with this project. Recall how most of what we animate, such as asteroids and bullets, extend the moving object class. Now take a look at ```game_view.js``` and find the game loop:

```JavaScript
animate(time) {
    const timeDelta = time - this.lastTime;

    this.game.step(timeDelta);
    this.game.draw(this.ctx);
    this.lastTime = time;

    // every call to animate requests causes another call to animate
    requestAnimationFrame(this.animate.bind(this));
}
```

What's going on here? Well, it's actually pretty straightforward. We are simply binding our `this` to subsequent `requestAnimationFrame` calls in order to utilize our `this.lastTime` variable in the next call (we also had to declare `this.lastTime` and bind `this` in our `start` method). This all works because `requestAnimationFrame`'s callback takes one argument - a timestamp. Using this information, we can calculate `timeDelta` - the amount of time which has passed since the last frame.

So what do we do with this time delta? Let's trace it to the step method in our Game class:

```JavaScript
step(delta) {
    this.moveObjects(delta);
    this.checkCollisions();
}
```

Then to `moveObjects`:

```JavaScript
moveObjects(delta) {
    this.allObjects().forEach((object) => {
        object.move(delta);
    });
}
```

And finally to the `move` function in the `MovingObject` class:

```JavaScript
move(timeDelta) {
    // timeDelta is number of milliseconds since last move
    // if the computer is busy the time delta will be larger
    // in this case the MovingObject should move farther in this frame
    // velocity of object is how far it should move in 1/60th of a second
    const velocityScale = timeDelta / NORMAL_FRAME_TIME_DELTA,
        offsetX = this.vel[0] * velocityScale,
        offsetY = this.vel[1] * velocityScale;

    this.pos = [this.pos[0] + offsetX, this.pos[1] + offsetY];

    // ...
}

// ...

const NORMAL_FRAME_TIME_DELTA = 1000 / 60;
```

We have used our time delta to first calculate the percent difference between the actual and expected frame rate, then multiplied that ratio by the planned velocity (for both x and y) to account for extra computation time. In that case, as the comment says, we want to move the object further in this particular frame. Now, we can change our x and y velocity and the animation speed will be consistent despite CPU usage and across devices.