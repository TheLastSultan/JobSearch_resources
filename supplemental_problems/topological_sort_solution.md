## Question Two
We now have to account for the fact that our tuple is not made up of integers. However, since we are storing our vertices in a hash, this does not have a significant effect on our solution. We now keep track of the dependent and dependency more explicitly:

```ruby
def install_order2(arr)
  max = 0
  vertices = {}
  arr.each do |tuple|
    dependent = tuple[0]
    dependency = tuple[1]

    vertices[dependent] = Vertex.new(dependent) unless vertices[dependent]
    vertices[dependency] = Vertex.new(dependency) if dependency && !vertices[dependency]
    Edge.new(vertices[dependency], vertices[dependent]) if dependency
  end
  
  topological_sort(vertices.values).map { |v| v.value }
end
```
## Question 3

We can solve this problem by creating vertices of the characters, then finding the topological sorting of the vertices.

* Create a number of vertices equal to the size of alphabet in the given alien language. For example, if the alphabet size is 5, then there can be 5 characters in words. 

* For every pair of adjacent words in given sorted array:
  * Let the current pair of words be word1 and word2. One by one compare characters of both words and find the first mismatching characters.
  * Create an edge from the mismatching character of word1 to that of word2.
* Print the topological sorting of the vertices.

```ruby
def alien_letter_order(words)
  vertices = {}
  
  words.reduce(:+).split('').uniq.each do |letter|
    vertices[letter] = Vertex.new(letter)
  end
  
  (0...words.length-1).each do |i|
    word1, word2 = words[i], words[i + 1]
    smaller = word1.length < word2.length ? word1.length : word2.length
    
    (0...smaller).each do |j|
      if word1[j] != word2[j]
        Edge.new(vertices[word1[j]], vertices[word2[j]])
        break
      end
    end
  end
  
  topological_sort(vertices.values).map { |v| v.value }
end
```

### Discuss:
* What are the time and space complexities of this method?

### Credit:
* Adapted from [this](https://www.geeksforgeeks.org/given-sorted-dictionary-find-precedence-characters/) Geeks for Geeks problem.
