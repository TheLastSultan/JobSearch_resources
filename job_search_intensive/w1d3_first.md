# W1D3
## Partner A interviews Partner B

### Speak-N-Say (30 mins)
Write a function that takes in a number (like 1131) and prints out the 5 subsequent "generation" sequences e.g.

1st subsequent sequence = 211311  = 2 x "1's", 1 x "3's", 1 x "1's"
2nd: 12211321
3rd: 112221131211
4th: 21322113111221
5th: 121113222113312211

### Solution
```ruby
def speak_n_say(num)
  num_str = num.to_s
  5.times do
    result = ''
    counter = 1
    this_char = num_str[0]
    num_str.chars.each_with_index do |char, i|
      next if i == 0
      if char == this_char
        counter += 1
      else
        result += counter.to_s
        result += this_char
        this_char = char
        counter = 1
      end
    end
    result += counter.to_s
    result += this_char
    p result
    num_str = result
  end
end
```

### React Fast (5 + 5 mins)
What makes React fast compared to other front ends? Research and expand your response!
