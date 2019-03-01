# W1D3
## Partner B interviews Partner A

### Rocks and Water (40 mins)

Given:  a string of stars (rocks) and tildas (water)....

 \*\*\~\~\*\~\*\~\~\*\~\*\*\*\~\~\~\*

Given: You start at index 0 and your speed is 0.

Given:  At each step you can only do one of three things: speed += 0; speed += 1, speed -=1
         ...e.g. if your speed = 2, you will advance 2 indices on the string.

```ruby
 rocks_and_water('**~*~*~~*~***~~*') ==> true
 rocks_and_water('**~~~*~*~~*~***~~*') ==> false
```

### Solution

```ruby
def rocks_and_water(str, speed = 0)

  return true if str[0] == '*' && str.length == 1

  return false if str[0] == '~'

  result1, result2, result3 = false, false, false

  unless speed == 0 || speed > str.length
    result1 = rocks_and_water(str[speed..-1], speed)
  end

  unless speed + 1 > str.length
    result2 = rocks_and_water(str[speed+1..-1], speed + 1)
  end

  unless speed == 0 || speed - 1 > str.length
    result3 = rocks_and_water(str[speed-1..-1], speed - 1)
  end

  result1 || result2 || result3
end
```
