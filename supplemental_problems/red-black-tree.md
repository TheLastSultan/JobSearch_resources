## Building a Self Balancing Binary Search Tree

Today, you will be modifying your binary search tree to be self-balancing. Recall that the time complexity for insertion and deletion from a binary search tree is ```O(depth)```, where ```depth``` is the height of the tree. It is therefore advantageous to minimize the height of our tree to maintain  ```O(log n)``` operations.

There are many different types of self-balancing binary search trees. These include:

* AA trees
* AVL trees
* Scapegoat trees
* Splay trees
* Treap (Tree + Heap)

Today you will be implementing a type of self-balancing tree called a *red-black tree*. Start by watching these [videos](https://www.youtube.com/watch?v=qvZGUFHWChY&list=PL9xmBV_5YoZNqDI8qfOZgzbqahCUmUEin) (< 20 minutes) for an introduction to red-black trees. Then, open up your solution to the binary search tree project and make a copy of ```binary_search_tree.md```. Modify your BST to be a self-balancing red-black tree.

NB: This is a difficult data structure to implement, which is why historically it has been left out of the App Academy curriculum. Don't feel bad if you are not able to complete it in the time allotted - just push it to your GitHub and come back to it later. If you come up with an interesting implementation, please share it with ```career-coaches@appacademy.io```.

### Solution
* [Link](https://gist.github.com/jamesyang124/c7a9256af58cd0f1e0fe)
* Credit: James Yang
