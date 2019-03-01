## Practical Problems Workshop

You should be prepared to discuss Ring Buffers and Dynamic Arrays as ways to optimize the array data structure. Specifically using them to solve problems will be less of a concern, since they don't provide any real special functionality. Let's practice some interview problems that involve arrays, though :)

---
## Single Element in a Sorted Array

Given a sorted array consisting of only integers where every element appears twice except for one element which appears once. Find this single element that appears only once. Do it in O(logn) time and O(1) space!

---
### Things you should be thinking of
* O(logn) should immediately make you think of Binary Search.
* What condition are we checking for?
* How do we know which direction to go next?

---

## Well-formed String

A string with the characters `[,],{,},(,)` is said to be well-formed if the different types of brackets match in the correct order.

For example, `([]){()}` is well-formed, but `[(]{)}` is not.

Write a function to test whether a string is well-formed.

### [Solutions](https://github.com/appacademy/sf-job-search-curriculum/blob/master/supplemental_problems/dynamic_array_solution.md)
