Here's a brain dump of my job search experience. Hope it helps you!

### 1. Studying

* Implement all of these Data structures in a language of your choice(I chose Ruby):
  * Linked List
  * Dynamic array, implemented with a ring buffer (use a statically sized array underneath the hood)
  * Hash set
  * Hash map (with chaining)
  * Binary heap (without decrease-key; know that Fibonacci heaps exist and know their guarantees)
  * Binary search tree (doesn’t need to be self-balancing; know that self-balancing trees exist and know their guarantees)
  * Prefix tree (a.k.a. trie)
  * Suffix tree (don’t worry about compression, just build a dumb version; know that Ukkonen’s algorithm exists and learn its guarantees)
  * An object-oriented adjacency list for graphs
* Implement all of these algorithms in a language of your choice:
  * Binary search (implement it both iteratively and recursively)
  * Randomized quicksort (pay extra attention to the partition subroutine, as it’s useful in a lot of places)
  * Mergesort
  * Breadth-first search in a graph
  * Depth-first search in a graph (augment it to detect cycles)
  * Tree traversals (pre-order, in-order, post-order)
  * Topological sort (using Tarjan’s algorithm)
  * Dijkstra’s algorithm (without decrease-key)
  * Longest common subsequence (using dynamic programming with matrices)
  * Knapsack problem (also dynamic programming)
* Know how to identify and solve backtracking problems. Loads of first technical phone screens on Collab-edit type environments were backtracking problems.

https://leetcode.com/tag/backtracking/

* Good questions to ask yourself:
  * What are the advantages of Single-Page Applications? What are the disadvantages of SPAs?
  * Why Rails? Advantages/Disadvantages

### 2 . Practicing

Books:
* Cracking the coding interview
* Elements of Programming in Java or in C++, doesn't matter - The have a roadmap section, helps structuring which problems to tackle.
* LeetCode - Sign up for this, helped me a lot when practicing

This post helped me a lot for structuring my learning - http://shlegeris.com/2016/06/22/ctci.html

System design questions:
  * https://github.com/checkcheckzz/system-design-interview
  * https://www.hiredintech.com/system-design/

Read engineering blogs:
  * https://eng.uber.com/
  * https://segment.com/blog/
  * https://blog.cloudflare.com/
  * https://blog.filippo.io/
  * http://highscalability.com/
  * http://blog.memsql.com/cache-is-the-new-ram/
  * http://highscalability.com/blog/2014/11/24/a-flock-of-tasty-sources-on-how-to-start-learning-high-scala.html
Do Mock interviews, both technical phone screen mocks and whiteboarding mocks. Do soft skills mocks as well(Product based interview questions)

### 3. Figuring out which companies to apply to

- Here are some sources that helped me see which helped me identify which companies to watch out for:

- https://breakoutlist.com/
- http://www.kpcb.com/companies
- http://www.greylock.com/greylock-companies/
- https://a16z.com/portfolio/
- https://news.ycombinator.com/ - Reading this site and keeping up to date with what's new in the industry is important!

The big thing here I realized for me was the mission of a company. What is it about the mission of the company that would motivate me to work over there? Answering this question helped me form my list!

### 4. Reaching out

* Referrals, if you have some
* LinkedIn 2nd Degree connections: Reaching out to your first degree connections asking for an intro, high chances that they will respond positively!
* Meetup groups + events:
  * https://www.meetup.com/golangsf/ - my favorite one
  * http://www.meetup.com/ReactJS-San-Francisco/
  * http://www.meetup.com/sfruby/

### 5. Phone Screens

Always show your determination to work. Ask every phone screen this (be ready to do some work!)

"I like to showcase my skillset by doing a simple project. I was wondering if you have a public API exposed, and if you do, is it possible for me to submit a simple project using your API?"

If no API,

"I like to showcase my skillset by doing a simple project. I was wondering if could submit a little project before I come into an onsite. The project can be something you decide that would best represent the skills needed for the job position. If not, I have some ideas too!"

Every interviewer will be impressed by this. It will put a lot of work on your plate though so be ready for that!

### 6. Take home challenges

* The company will usually ask you when to send it. Ask for it on a Thursday or a Friday. Then, you can use the weekend to complete it too. They will not ask for it back on a Saturday or Sunday, Monday morning is the usual answer.
* Make sure to allocate more hours on this than they suggest, it shows that you are really interested
* Use object oriented programming principles
* TESTING (PLEASE WRITE TESTS)
* Write a good README : Talk about the set up instructions, design choices, potential improvements, how would you scale this app.
* If they ask you to come in after you submit your coding challenge, make sure to revisit your coding challenge and think of ways to improve it.
* Create a branch called "improvements" and improve some of the code
* Always put up your code on Github(or something similar): This shows you are well adept at using a versioning system.

Here's my take home challenge for Cloudflare: https://github.com/mihirjham/certificates-rest-api

### 7. Researching a company

* Company website
* Crunchbase
* Learning about their competitors
* Watch videos on youtube about their founders, their product, any talks they've given, etc.
* Have important questions about product
* Read their blog(IMPORTANT)
* https://mitmproxy.org/ => To better understand some of the API structures and analyze how they are handling requests.

### 8. Onsite

* One day before the onsite, don't do anymore problems from Cracking the coding interview. Just research the company. Don't psych yourself out.
* Enjoy the interview, show that you are interested by asking good questions.
* Also, know your reasons why you want to join that company and what you bring to the table. I always wrote down why I wanted to join the company one day before. What excites you about the challenges, the team and the experiences

Here are my template questions I asked every company (I'm using Cloudflare as an example):

* What are your current priorities and focus areas at Cloudflare?
* How would you define the culture at Cloudflare? How do you think it fosters talent, helps people grow to the next level and be their best?
* What more would you like to see from the engineering team at Cloudflare?
* Can you describe how a product like Universal SSL went from its inception as an idea to shipping it to production?
* What is the most challenging question about Cloudflare or the market you've been asked in the last 30 days by a candidate, a member of the press, an investor, a customer or an employee?
* Has your website ever gone down? How did you tackle that challenge and bring it back up? What has been added since then to reduce the risk of letting your website go down?

Some more questions you could ask:
* http://www.theeffectiveengineer.com/blog/how-to-distinguish-yourself-from-other-interview-candidates
* http://blog.pamelafox.org/2013/07/what-to-look-for-in-software.html


### 9. Negotiations

I failed this part miserably, but here's are good blog posts to help you with that

* http://haseebq.com/how-not-to-bomb-your-offer-negotiation/
* http://www.kalzumeus.com/2012/01/23/salary-negotiation/
* Know the current market rate: https://docs.google.com/spreadsheets/d/1mR9RTOHbdqHVAI1JxXeMYfhzYJ2n7R-_Pur81POisCc/edit#gid=0

### 10. Evaluating your job offer

* https://blog.wealthfront.com/new-college-grad-stock-compensation/
* https://medium.com/@iancorbin/better-understanding-your-employee-stock-options-9c4b147b5ded#.ynzx3a2u1
* https://blog.wealthfront.com/stock-options-14-crucial-questions/

Some more resources that I used:

https://gist.github.com/ronnieftw/7907630469242f0999ea
