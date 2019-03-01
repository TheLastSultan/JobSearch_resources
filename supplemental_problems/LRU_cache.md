
## Problem 1: BST to LL

Given the root node of a binary search tree,
return an in-order doubly-linked circular linked list

You can solve this in 0(1) extra space by reassigning the left / right
pointers of the tree to function as prev / next pointers for a linked list


```
input:
     3
   /   \
  1      5
 / \     / \
0   2   4   6

output:

... 6 <=> 0 <=>1 <=> 2 <=> 3 <=> 4 <=> 5 <=> 6 <=> 0 ...

or...

 0 <=> 1 <=> 2
 ^		^
 |		3
 v		v
 6 <=> 5 <=> 4
```

return the node in the LL that has the lowest value (0 for this example)


### Solution
```ruby
class Node
	attr_accessor :left, :right, :val
	def initialize(val)
		@val = val
		@left, @right = nil, nil
	end

	def print
		str = "#{val} -> "
		current = self.right
		while current != self && current != nil
			str += "#{current.val} -> "
			current = current.right
		end

		if current == nil
			str += "nil"
		else
			str += "#{current.val} -> "
		end
		puts str
	end
end

def bst_to_cll(node)
	if !node.left && !node.right
		node.left = node
		node.right = node
		return node
	end
	p node.val
	right = node.right
	left = node.left

	if left
		lowest_left = bst_to_cll(left)

		node.left = lowest_left.left
		lowest_left.left.right = node

		node.right = lowest_left
		lowest_left.left = node
	end


	if right
		lowest_right = bst_to_cll(right)

		max = lowest_right.left
		lowest_left = node.right



		max.right = lowest_left
		lowest_left.left = max
		
		node.right = lowest_right
		lowest_right.left = node

		return lowest_left
	end

	return node.right
end


root = Node.new(3)

root.right = Node.new(5)
root.right.right = Node.new(6)
root.right.left = Node.new(4)

root.left = Node.new(1)
root.left.left = Node.new(0)
root.left.right = Node.new(2)

root.print

smallest = bst_to_cll(root)

smallest.print
```



## Problem 2: System design:

If you are not familiar with TinyRUL, I’ll briefly explain here. Basically, TinyURL is a URL shortening service, a web service that provides short aliases for redirection of long URLs. There are many other similar services like Google URL Shortener, Bitly etc..

For example, URL http://blog.gainlo.co/index.php/2015/10/22/8-things-you-need-to-know-before-system-design-interviews/ is long and hard to remember, TinyURL can create a alias for it – http://tinyurl.com/j7ve58y. If you click the alias, it’ll redirect you to the original URL.


So if you would design this system that allows people input URLs with short alias URLs generated, how would you do it?


source: http://blog.gainlo.co/index.php/2016/03/08/system-design-interview-question-create-tinyurl-system/

Congratulations! Your site is getting a lot of traffic. Unfortunately this means you have a lot of urls to save, and when it comes time to retrieve a long URL, you will have to search through a massive amount of short urls.

One additional thing to consider when designing this system is the number and distribution of requests coming into your site.

For this example, lets say 95% of the requests to your service are made up of the top 200 most popular urls on your site. The other 3 million urls in your database are fetched by the remaining 5% of your request traffic. What additional data structure could you use to reduce the number of queries made to your database and decrease the computational load on your system?




## Problem 3:

Write an instance method to reverse a linked list


### Solution

``` ruby
class Node
  attr_accessor :value, :next

  def initialize(value, next_node)
    @value = value
    @next = next_node
  end
end

class LinkedList
  attr_accessor :head, :tail

  def add(value)
    if(@head.nil?)
      @head = Node.new(value, nil)
      @tail = @head
    else
      @tail.next = Node.new(value, nil)
      @tail = @tail.next
    end
  end

  def reverse(list)
    return nil if list.nil?
    prev = nil
    curr = list.head

    while(curr != nil)
      temp = curr.next
      curr.next = prev
      prev = curr
      curr = temp
    end
    list.head = prev
    list
  end

  def display(list)
    return nil if list.nil?
    curr = list.head
    arr = []
    while(curr != nil)
      arr.push(curr.value)
      curr = curr.next
    end
    p arr
  end
end

list = LinkedList.new()
list.add(1)
list.add(2)
list.add(3)

list.display(list)                #list before reversing [1,2,3]
list.display(list.reverse(list))  #list after reversing  [3,2,1]
```
source: https://stackoverflow.com/a/38554200
