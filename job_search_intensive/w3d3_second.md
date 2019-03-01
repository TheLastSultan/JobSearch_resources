# W3D3

## Partner B Interviews Partner A

### Happy Numbers (25 mins)
Determine whether the sum of every digit in a number squared will eventually equal 1.

`input: 25 => 2**2 + 5 **2 => 29 => 2**2 + 9**2 => 85 ... etc ... => false`
`input: 10 => 1 => true`
`input: 4 => 16, 37, 58, 89, 145, 42, 20, 4 => false`

### Solution

```ruby
def happy_numbers(int)
  cache, num = Hash.new(false), int
  until num == 1
    cache[num] ? (return false) : cache[num] = true
    num = to_string(num)
  end
  true
end


def to_string(int)
  int.to_s.chars.map(&:to_i).reduce(&:+)
end
```

### HTTP and CORS

What is HTTP and how does it work? What are HTTP Headers, what are they for, and give some examples of their usage? What is CORS and how is it used?

### Solution
* [List of HTTP header fields](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields)
* [HTTP headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers)

* [Cross-Origin Resource Sharing (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)
* [Cross-origin resource sharing](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)
