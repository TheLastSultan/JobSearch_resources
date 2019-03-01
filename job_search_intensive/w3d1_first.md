# W3D1

## CoderPad-Style Interview
Solve this problem in your code editor

## Partner A Interviews Partner B

### Longest Substring with K Uniques (40 mins)

Find the longest substring with K unique characters in a given string

Given a string you need to print longest possible substring that has **exactly** K unique characters. If there are more than one substring of longest possible length, then print any one of them.

```
"aabbcc", k = 1
Max substring can be any one from {"aa" , "bb" , "cc"}.

"aabbcc", k = 2
Max substring can be any one from {"aabb" , "bbcc"}.

"aabbcc", k = 3
There are substrings with exactly 3 unique characters
{"aabbcc" , "abbcc" , "aabbc" , "abbc" }
Max is "aabbcc" with length 6.

"aaabbb", k = 3
There are only two unique characters, thus show error message.

"aabccdeeeeeeee", k = 3
Max is "ccdeeeeeeee" with length 11
```


### Solution

Method 1 (Brute Force)
If the length of string is n, then there can be n*(n+1)/2 possible substrings. A simple way is to generate all the substring and check each one whether it has exactly k unique characters or not. If we apply this brute force, it would take O(n2) to generate all substrings and O(n) to do a check on each one. Thus overall it would go O(n3).

We can further improve this solution by creating a hash table and while generating the substrings, check the number of unique characters using that hash table. Thus it would improve up to O(n2).

This is not good.

Method 2 (Linear)

Make a window, keep track of the number of uniques and what they are, update window for each character, if number of uniques is exceeded take items off the front of the window, replace the longest window any time your current window is longer.

```ruby
def longest_with_k_unique(str, k)
  start = 0
  finish = 0
  uniques = Hash.new(0)
  uniques_count = 0
  longest = [start, finish]
  chars = str.chars
  chars.each_with_index do |char, i|
    uniques_count += 1 if uniques[char] == 0
    uniques[char] += 1
    finish = i
    if uniques_count > k
      # p "exceeded at #{i}", uniques
      until uniques_count <= k
        uniques[chars[start]] -= 1
        uniques_count -= 1 if uniques[chars[start]] == 0
        start += 1
        # p uniques
      end
    end
    if finish - start >= longest[1] - longest[0]
      longest = [start, finish]
    end
  end
  result = str[longest[0]..longest[1]]
  p uniques_count == k ? [result, longest] : "No substring with that number of uniques found!"
end
```
