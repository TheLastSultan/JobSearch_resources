# W2D1

## Partner B Interviews Partner A

### Using React (20 mins)

Say that you have an index.html page, what do you you need to do to use React on your site?

What do you need to do with React to interact with elements on the page and how does it do that?

### Solution

Part A: npm install the correct packages for React and Babel (why?), set up webpack and entry file, OR...use a CDN to just give you the libraries on your HTML page and write your code! [How to add React to a simple HTML file](https://medium.com/@to_pe/how-to-add-react-to-a-simple-html-file-a11511c0235f)


Part B: From within a component class, `this.refs` gives you an object containing key:value pairs of `ref`s and `DOM` nodes that you will have created within this class. When you create an HTML element in your code, you can pass it a `ref` prop.

`render: function() {
  return <input placeholder='Email' ref='email' onFocus={this.onEmailFocus} />;
},`

`onEmailFocus: function() {
  this.refs.email.blur();
}`

You can also get references to the top level node returned by any component's render function by calling

`ReactDOM.findDOMNode(componentInstance)`

[React.js By Example: Interacting with the DOM](http://jamesknelson.com/react-js-by-example-interacting-with-the-dom/)

### Anagrams (35 mins)
Given an array of strings, return an array of strings with anagrams grouped together.

### Solution

```ruby
def anagram_buncher(arr)
	arr.each_with_object(Hash.new { |h, k| h[k] = [] }) do |w, h|
		h[w.chars.sort] << w
	end.values.flatten
end
```
