# Binary Search Trees

The data structure we'll be learning about today is used ubiquitously in software.  You've even used it yourself, but perhaps without realizing it.  We define this data structure with a few goals in mind:

1. Key operations, namely `#find`, `#insert`, and `#delete`, should run fast on this data structure,
2. The data set and the order in which it is entered into our data structure should not (drastically) affect the way these operations work or how fast they perform.

With that, we begin by defining how a *binary search tree* is built.

## Building a BST

Imagine that we have a data set that we would like to store, perhaps a list of integer values, `data = [3, 2, 10, 5, 6, 0, 4]`.  We will use an array to build a binary search tree (BST) using `data` as an example set.  A BST is made up of *nodes*; each value in `data` will be stored in one of these nodes.  The nodes themselves will be connected using very specific parent-child relationships that, as we'll see, will help us keep our data organized and define our three key operations.  Each BST originates with a single node called the *root*.  We'll build our tree, `bst`, starting with `data[0] = 3`.  

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/build_bst_1.png)

Notice that so far, `bst` = `bst.root`. That won't be the case for long, as we'll start inserting the rest of the values in `data`. To do so, we first need to define the parent-child relationships we alluded to previously.  The rules are straightforward:

1. Each node can have up to two children: a left child, a right child, both, or neither.  Each child is a node as well, and is the root of its corresponding *subtree* (e.g., the root's left child is the root of the *left subtree*).
2. The values of each node in the left subtree must be *less* than the value of the root.
3. The values of each node in the right subtree must be *greater* than the value of the root.

Let's follow these rules to decide where `data[1] = 2` should go. Since the value of the root is 3, we must put 2's node (let's refer to it as `2` for convenience) into the left subtree, since 2 < 3.  We do so by making `2` into `3`'s left child:

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/build_bst_2.png)

Next we want to add `10` to the tree.  Since 10 > 3, we must put `10` into `3`'s right subtree:

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/build_bst_3.png)

Now things get tricky.  The root node `3` already has a left and a right child, so where shall we put `5`?  Let's recall our list of rules: since 5 > 3, we must put `5` into `3`'s right subtree.  However, we cannot make `5` the right child of `3`; that position is taken by `10`.  So, we must make `5` into one of `10`'s children.  Since 5 < 10, `5` becomes `10`'s left child:

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/build_bst_4.png)

We're now seeing a pattern develop.  Before moving on, let's formalize this method into our first key operation: `#insert`.

**Steps to `#insert(value, root)`**

1. Compare `value` to `root` to decide into which side of the tree `value` should be inserted.
2. If `value > root`, check for `root`'s right child.  If `root` has a right child, perform `insert(value, root.right_child)`.  Otherwise, make `value` into `root`'s right child.  
3. If `value < root`, check for `root`'s left child.  If `root` has a left child, perform `insert(value, root.left_child)`.  Otherwise, make `value` into `root`'s left child.  

**NB**: Notice that `#insert` is inherently a recursive algorithm.  That's going to be the case with many of the methods that we'll write for the BST.  

Let's add one more node to the tree to practice this method.  

**Step 1.** The next value, `data[3] = 6`, is greater than the root, so `6` must be added to the right side of the tree.

**Step 2.** `3` already has a right child, so we perform `insert(6, 3.right_child)`.

**Step 3.** Examine `3.right_child = 10`.  Since 10 > 6, `6` must be added to `10`'s left.

**Step 4.** `10` already has a left child, so we perform `insert(6, 10.left_child)`.

**Step 5.** Examine `10.left_child = 5`.  Since 5 < 6, `6` must be added to `5`'s right.

**Step 6.** `5` has no right child, so `6` becomes `5`'s right child, and our algorithm terminates.

The resulting BST is shown below.

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/build_bst_5.png)

On your own, use this algorithm to insert the final two elements from `data` into our BST.  (If you want to check your work, head down to the very beginning of the next section.)

You may wonder why we chose to insert using this algorithm.  Perhaps you can imagine other ways of inserting new items into a BST that would still maintain its structure.  This is not the *only* way to define `#insert`, but it is the canonical way for a couple reasons.  One is the simplicity of this algorithm; it's easy to understand and to execute.  The other is that it is extremely fast, at least for "ideal" BSTs.  We'll come back to the time complexity later.  

There are a couple other unanswered questions about this algorithm, too.  First, does it always work?  Will we always be able to find a "landing" position for the element we wish to insert?  The answer is yes -- so long as all of our elements are pairwise comparable (that is, we can always tell whether `node1 > node2` or `node1 < node2`).  If this is the case, then each step of our algorithm can always be resolved.  And of course, since our tree is necessarily of finite size, we will always encounter an endpoint at which we can place our node.  

One last point: what about the case in which our data set *does* contain repeats?  This is a common problem that we must address.  Our solution is to change our BST definition only slightly: instead of requiring that all elements of left subtree are less than the root, we'll require that all elements are *less than or equal to* the root. We also must propagate this change to our `#insert` method -- exactly how is left to you as an exercise.

## Key Operation 2: `#find`

We have successfully defined `#insert`. The function `#find` is quite similar. Let's think about how we might do this, using our tree from the previous section as an example:

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/build_bst_soln.png)

Imagine that we want to perform `tree.find(5)`. How might we do this? Let's start at the obvious place: the root. Since the root's value is 3 and 3 < 5, we know that 6 must be in `tree`'s right subtree, or it can't be in `tree`. So, we turn our attention towards the right subtree:

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/bst_find_1.png)

Now, we perform a similar analysis: the root of `tree.right_subtree` is 10, so if 5 can be found, it'll be in `10`'s left subtree:

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/bst_find_2.png)

And now, the root of the tree we're searching (`tree.right_subtree.left_subtree`) is equal to 5, so we return `true`. The image below summarizes our steps.

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/bst_find_4.png)

What happens if the value we're trying to find isn't in our tree?  This case is essentially `insert(val)`; we're trying to find the place within the tree that, by design, *must* contain `val` if indeed `tree` contains `val`.  We will know that we can return `false` if we cannot proceed in our tree in the necessary direction. For example, let us attempt to `find(7)` in `tree`:

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/bst_find_5.png)

Let's summarize the steps that we're taking in our `find(val)` algorithm:

**Step 1a.** Check `root.nil?`.  Return `false` if the root is `nil`.

**Step 1b.** Compare `root` to `val`. Return `true` if they're equal.

**Step 2.** If `root > val`, perform `root.right_subtree.find(val)`.

**Step 3.** If `root < val`, perform `root.left_subtree.find(val)`.

Note that as with `#insert`, the `#find` algorithm is recursive. In fact, the two algorithms are nearly identical.

## Key Operation 3: `#delete`

Our next function, `#delete`, is a little more challenging. We have a couple different cases we must consider. We'll start with the easiest case: that in which the node to be deleted has no children. Imagine we'd like to perform `delete(6)` on the tree below:

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/bst_delete_1.png)

The reason that this case is easy is because we can simply erase `6` without anything much changing. Since `6` has no children, it leaves no orphaned nodes when it is deleted.  We'll get more into the practicalities of "erasing" `6` during the hands-on portion of this project.

Let's explore the case where our node to be deleted has one child.  For instance, let's perform `delete(10)`. Now, in addition to deleting `10`, we must replace it with something in order to maintain a cohesive BST. There's an obvious solution: simply "promote" `10`'s child, making `10`'s parent its new parent, as shown below.

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/bst_delete_2.png)

Although this looks like it's a fine way to delete `10`, we must ensure that this actually works.  That is, can we perform this promotion and be sure that we'll be left with a BST? This is really two questions:

1. `10` was the root of `5`'s right subtree. Now `6` has replaced `10` as root. Are all elements in this subtree still greater than `5`?
- **Yes**. All the elements in this subtree were *already* in `5`'s right subtree. Hence, by the rules of the BST, all these nodes had (and still have) greater value than 5.
2. Is the subtree rooted by `6` still a BST? That is, are all the nodes to `6`'s right greater than 6, and all to its left less than 6?
- **Yes**. We haven't changed anything about the subtree rooted by `6`, so it is still a BST.

Great! One more case to go, and that is the case in which our node to be deleted has both a left and a right child. Say we want to perform `delete(15)` on `tree2`, pictured below. Because `15` has two children, this is going to disrupt the tree considerably. We want to choose a replacement for `15` that causes minimal disruption.

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/bst_delete_4.png)

The replacement, `r`, that we choose for `15` must satisfy three conditions:

1. `r` must be greater than every element in `15`'s left subtree.
2. `r` must be less than every element in `15`'s right subtree.
3. We must be able to easily resolve the fates of the children of `r`.

Let's start with a simple choice: which side of the original tree shall we pick from? We choose left (we'll see later that our choice here doesn't matter). Since `r` will come from the left subtree, condition 2 above is automatically satisfied; every element in the left subtree is less than every element in the right subtree (why?). To ensure that `r` is greater than every node in its left subtree, we do the obvious thing: we choose the *largest* node in `15`'s left subtree.

We must take a small detour here to ensure that we are able to easily find the maximum (or, analogously, the minimum) of a BST, as we wish to call `max(tree.left_subtree)`. This is an easy problem, it turns out. As always, we begin at the tree's root node. All nodes greater than the root are to its right, so we look for the root's right child. If it has one, we in turn find the *right child* of this right child. We proceed in this way until we cannot go any further to the right. This final right child is the maximum of the tree, as illustrated below.

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/bst_delete_5.png)

Pause here and ask yourself two questions:

1. Why are we guaranteed to find the maximum with this algorithm?
2. How would you find the minimum of a BST?

We now have our `r`, which satisfies both of our conditions; since `r` = `14` is the maximum of the left subtree, it'll be greater than every element in the *new* left subtree once it replaces `15` as the root. `r` also remains less than every element in the original (now its own) right subtree:

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/bst_delete_6.png)

Now that we've promoted `r` to replace `15`, we must take care of one last piece: what should we do with `r`'s left subtree? Since we are in essence "deleting" `r` locally, we will treat this as we did our second case in this analysis: we promote `r`'s left child to take its place:

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/bst_delete_7.png)

This works, but what would we do if `r` had two children instead of one? Fortunately, this case *cannot* occur; if it did, then `r` would not be the maximum of `3`'s left subtree, because its right child would be larger. Hence, we have buttoned up all our cases, and we're ready to summarize the steps to our `delete(val)` algorithm:

**Step 1.** Perform `find(val)`.
**Step 2.** If `val` has no children, "erase" `val`.
**Step 3.** If `val` has one child, promote this child to take `val`'s place, keeping everything else the same.
**Step 4a.** If `val` has two children, find the maximum element in `val`'s left subtree. Call this node `r`.
**Step 4b.** Replace `val` with `r`.
**Step 4c.** If `r` had a left child, promote this child to take `r`'s place. Keep everything else the same.

Notice that in Step 4a, we could well have made a different choice: we could have replaced `val` with the *minimum* of the *right* subtree. Spend a moment convincing yourself that this would work.

This algorithm is known as *Hibbard deletion* and is widely used in BST implementations. As with `#insert`, there are other ways to delete from a BST, but we will not cover them here.

## Time Complexity

We began this reading with a promise to create a data structure that performed `#find`, `#insert`, and `#delete` *fast*. Now it's time to see if that's true. Let's start with `#find`. Recall the work that we did to `find(6)` in `tree`:

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/bst_find_6.png)

Notice that at each new *level* of the tree, we make a binary choice, comparing 6 to the node we're currently exploring. This comparison takes `O(1)` time. Hence, what matters here is the *number of levels* in the tree. We refer to this as the **depth** of the tree.

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/bst_depth.png)

All the operations `#find`, `#insert`, `#max`, and `#min` run in `O(depth)` time, since we traversing at most `depth` levels of the tree, performing a `O(1)` operation at each level. Similarly, `#delete` is `O(depth)` because we must perform both `#find` and `#max` (or `#min`) throughout the course of performing `#delete`.

Now we ask ourselves another question: what are the bounds on `depth` in terms of `n`, the number of elements in the tree? On one extreme, we can imagine a tree which is complete, or close to it: that is, all or almost all of the available spaces for nodes are occupied. Here's one such example:

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/full_tree.png)

In a tree such as this, the <i>k</i>th level of the tree contains approximately 2<sup><i>k</i> - 1</sup> nodes. We add up the number of nodes level by level, leaving us with the following equation:

<i>n</i> = 1 + 2 + 4 + ... + 2<sup><i>depth</i> - 1</sup>

Recall that consecutive powers of 2 add nicely, that is, 1 + 2 + 4 + ... + 2<sup><i>m</i> - 1</sup> = 2<sup><i>m</i></sup> - 1 for any positive integer *m*. Using this fact on the right side of our equation yields:

  <i>n</i> = 2<sup><i>depth</i></sup> - 1

=> <i>n</i> + 1 = 2<sup><i>depth</i></sup>

=> <i>log</i><sub>2</sub> (*n*) = *depth*

In other words, `O(depth) = O(log n)` if our BST is full or close to full. However, here is an example of a BST on the other extreme:

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/degnerate.png)

Such a tree is often referred to as *degenerate*. Spend a moment convincing yourself that this tree is, in fact, a BST. Here, each of the *n* nodes is on its own level, so *depth* = *n*. That means, in turn, that `O(depth) = O(n)`, which is not nearly as fast as `O(log n)`.

There are cases in between these two extremes as well. In fact, one of the downsides of Hibbard deletion is that if we insert and delete elements ad nauseam, we'll eventually end up with a tree that has *depth* = \sqrt{n}. That's also the case with all other known deletion algorithms for the BST (at least, those that *only* delete rather than delete and then perform some other operation on the tree). The reason that this happens is well beyond the scope of this course.

If we're to use the BST data structure, we'd like to find a way to ensure that we're always getting that nice, fast `O(log n)` time complexity. The next section will explore how we can do just that.

## Balanced Trees

The first thing that we must do is decide what it means for a tree to be "acceptable" or "good". We want to define a condition on our trees such that when this condition is met, *depth* &asymp; *log*<sub>2</sub>*n*. We will call this condition *balanced* and define it as follows:

**Definition**. A binary search tree, `bst`, is *balanced* if (and only if) the following are true:
1. The depths of `bst.right_subtree` and `bst.left_subtree` differ by at most 1,
2. Both `bst.right_subtree` and `bst.left_subtree` are balanced BSTs as well.

Notice that just like our `#insert` and `#find` algorithms, this definition is recursive. Let's look at a couple examples to get the hang of what a balanced tree is. First, let's check the degenerate tree that we saw in the previous section:

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/degnerate.png)

The depth of `degenerate_bst.right_subtree` is 0, and `degenerate_bst.left_subtree` has a depth of 4. Hence, `degenerate_bst` is *not* balanced, since these two depths differ by 4 > 1. That's good! We want to exclude the degenerate case from our set of "acceptable" trees.

Let's next look at this tree:

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/hat_tree.png)

Notice that the depth of a tree like this will always be *n*/2, which means that all of our operations will run on this tree in `O(n)` time. So we hope that we determine this tree to be unbalanced. Indeed, it is: although we satisfy Step 1 of our definition of balanced, since `hat_tree.left_subtree.depth` - `hat_tree.right_subtree.depth` = 0, we do not satisfy Step 2. Both `hat_tree.right_subtree` and `hat_tree.left_subtree` are unbalanced. In fact, they are examples of the very degenerate case we saw a moment ago.

What about the other extreme, our "good" example tree?

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/full_tree.png)

Let's exercise our definition of balanced to check.

**Step 1.** Find the depths of `full_bst.left_subtree` and `full_bst.right_subtree`.

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/balanced_1.png)

The difference in the depths is 2 - 2 = 0. So far, so good!

**Step 2.** Determine if `full_bst.left_subtree` is balanced.

<ul>
<li><b>Step 2a</b> Compare the depths of the left and right subtrees of full_bst.left_subtree.

   ![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/balanced_2.png)

  The difference in the depths is 1 - 1 = 0. Still good!
  </li>
  <li><b>Step 2b.</b> Determine if `full_bst.left_subtree.left_subtree` is balanced. This tree consists of a single node, so the depths of both its subtrees are 0. Hence, this tree is balanced.
  </li>
  <li><b>Step 2c.</b> Determine if `full_bst.left_subtree.right_subtree` is balanced. Once again, this tree is just a single node, so it is balanced.
</ul>

**Step 3.** Determine if `full_bst.right_subtree` is balanced.

<ul>
<li><b>Step 3a.</b> Compare the depths of the left and right subtrees of full_bst.right_subtree.

   ![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/balanced_3.png)

   The difference in the depths is 1 - 0 = 1. We're still balanced so far!
  </li>
  <li><b>Step 3b.</b> Determine if full_bst.right_subtree.left_subtree is balanced. This tree is empty, so it is vacuously balanced (i.e., there's nothing there to balance, so we consider it balanced by default).
  </li>
  <li><b>Step 3c.</b> Determine if full_bst.right_subtree.right_subtree is balanced. Once again, this tree is just a single node, so it is balanced.
</ul>

All three steps in our algorithm to determine balance hold true. Hence, our tree is balanced. Again, that's good! We want a case like this to fall into the "balanced" category.

Practice yourself to get the hang of this on one or two trees from earlier in the lesson.

## Self-Balancing Trees

In the wild, it's important that BSTs are balanced and remain so. Otherwise, we run the risk of our nice, logarithmic time complexities degrading into linear time. Implementations of BSTs handle this in different ways, but virtually all "real world" examples of BSTs have a mechanism to do this automatically. We won't go into any details here, because the algorithm is fiddly and not overly enlightening. However, the basic idea is that our BST will have a method `rebalance` built onto its prototype, and this method will be called after every insertion and deletion.

One of the bonuses to our hands-on lesson will be a walk-through of an **AVL tree**, which is another name for a self-balancing tree. There are esoteric differences between the terms *AVL tree* and *self-balancing tree*, but they don't matter too much outside of an academic context. Use these terms interchangeably with reckless abandon.

## Retrieving the Data

It's often the case that we want to get out all the values held in a binary search tree, for some reason or another. And, it's often the case that we want these results to be *sorted* -- after all, that's one of the main benefits of creating a BST in the first place. To do this, we perform what is known as an *in-order traversal* of the tree. Let's think about how we'd do this.

The node that we have immediate access to is the root. However, the root's value may not be (and probably is not) the smallest element in the data set. We want to put it *after* all the elements that are smaller than it. Those elements are housed in one place: the root's left subtree. Likewise, we want to put the root's value *before* all elements larger than it.  All those elements are sitting in the right subtree.

This gives us a clue as to what we should do: we ought to traverse the entire left subtree first, then look at the root's value, then traverse the right subtree. This is exactly what we do:

**In-Order Traversal**
1. Perform an in-order traversal of the left subtree.
2. Record the value of the `root`.
3. Perform an in-order traversal of the right subtree.

Let's practice on a familiar example.

![](http://assets.aaonline.io/fullstack/job-search/algorithms/binary_search_trees/diagrams/build_bst_soln.png)

We'll do our recording by pushing into an array, `results = []`.

**Step 1.** Perform an in-order traversal of the left subtree.

**Step 1a.** Perform an in-order traversal of the left subtree's left subtree. The left subtree is a single node, `0`. When we perform this traversal, we implicitly explore the left, but because it is empty, we immediately return to the root node, `0`. We now record that node by pushing its value into `results`. Then, we implicitly explore the right subtree, which is also empty. Hence, our exploration of this sub-subtree is finished.

  After this step, `results = [0]`.

**Step 1b.** Record the value of `root`. Here, `root` = `2`, because we are still thinking within the context of traversing the *left subtree* of the original. So, we push `2` into `results` and `results = [0, 2]`.

**Step 1c.** Perform an in-order traversal of the right subtree. This subtree is empty, so our traversal terminates immediately.

**Step 2.** Record the value of the `root`. We're back in the context of the original tree, so `root` = `3`. We push 3 into `results`, so `results = [0, 2, 3].`

**Step 3.** Perform an in-order traversal of the right subtree. This is a lot like Step 1!

**Step 3a.** Perform an in-order traversal of the right subtree's left subtree. The left subtree is a single node, `4`. Just like our previous traversals of singleton nodes, we explore the empty left, push 4 into `results`, and explore the empty right. Now, `results = [0, 2, 3, 4]`.

**Step 3b.** Record the value of `root` = `5`. Now, `results = [0, 2, 3, 4, 5]`.

**Step 3c.** Perform an in-order traversal of the right subtree, another singleton node, `6`. Then, we are back in the context of its parent, so we record the value of the root. After this step, `results = [0, 2, 3, 4, 5, 6, 10]`.

Lo and behold, we return our sorted data set, `[0, 2, 3, 4, 5, 6, 10]`.

## Your Turn

In this lesson, we've talked through the conceptual construction of a BST along with the algorithms we'd use to accomplish some basic tasks.  We have not, however, talked much at all about implementation. That's next. In Phase 1, we'll walk through an implementation of a BST in Ruby. In Phase 2, you'll use your BST knowledge to solve a fairly typical BST problem.

The instructions for the 2 phases are in the project's README.
