# Big O Extra Credit

Think through these time complexities if you wanted some additional 
bonus practice!

```javascript
var a = 1;
var b = 1;

for (i = 0; i < N; i++) {
  for (j = N; j > i; j--) {
    console.log(b);
    b += a;
  }
}
```

```javascript
for (i = 0; i < N; i++) {
  for (j = i+1; j < N; j++) {
    console.log(i);
    if (i + 5 > j - 2) {
      var spooky_sum = i - j + 2;
    }
  }
}
```

```javascript
for (i = 0; i < N; i++) {
  for (j = 0; j < M; j++) {
    var mimble = i*j;
    var thimble = i + j;
    console.log(mimble + thimble);
  }
}
```

```javascript
var spock = "Live long and prosper";
var picard = "Engage!";

for (i = 0; i < N; i++) {
  if(i % 2 === 0) {
    console.log(spock);
  } else {
    console.log(picard);
  }
}
for (j = 0; j < M; j++) {
  var kirk = "i have nothing to say";
}
```

```javascript
var notes = ["do", "rei", "mi", "fa", "so", "la", "ti", "do"];

for (i = 0; i < N; i++) {
  for (j = 0; j < N; j++) {
    var position = (i+j) % 8;
    console.log(notes[position]);
  }
}
for (k = 0; k < N; k++) {
  if (k < 8) {
    console.log("A great note is " + notes[k]);
  }
}
```

### Recursion's Revenge: Bubbling Bountiful Bounds

Now let's take a look at some more challenging stuff. You may find yourself using bounding in this section, along with FFS for recursive functions. Take a look at this one first, which is a modication of `rec_mystery_3`:

```java
void rec_mystery_3(int n, int m, int o)
{
  if (n <= 0)
  {
    printf("%d, %d\n", m, o);
  }
  else
  {
    rec_mystery_3(n-1, m+1, o);
    rec_mystery_3(n-1, m, o+1);
    rec_mystery_3(n-1, m+1, o+1);
    rec_mystery_3(n-1, m, o);
  }
}
```

### Bonus
Nice work! Here's a bonus!
```javascript
Array.prototype.mixyUppy = function(){
  if (this.length === 1) {
    return [this];
  }

  var mixes = [];
  var prevMixes = this.slice(1).mixyUppy();

  prevMixes.forEach(function(mix) {
    mix.forEach(function(el, i) {
      mixes.push(
        mix.slice(0, i).concat(this[0], mix.slice(i))
      );
    }.bind(this));

    mixes.push(mix.concat(this[0]));
  }.bind(this));

  return mixes;
};
```


### Blustery Bonuses

Well done, Padawans. Soon you will command your own starships, perhaps even the Enterprise. Here are a couple of fun bonuses in the meantime.

#### `silly_years`

Hey, this will look familiar!  Write a function that takes in a 4-digit year and returns `true` if the number formed by the first two digits plus the number formed by the last two equal the number formed by the middle two. E.g.:

1978 => `true` since 19 + 78 = 97.
2003 => `false` since 20 + 3 does not equal 0.

What's the time complexity of this silly function? Pay special attention to constant factors here!

#### `digital_root`

Another blast from the past! Write a function that takes in a positive integer and sums its digits until a single digit remains. E.g.:

12345 => 6 since 1 + 2 + 3 + 4 + 5 = 15, and 1 + 5 = 6.

**NB**: you'll have to use bounding here. And even with that, it's really stinkin' hard!