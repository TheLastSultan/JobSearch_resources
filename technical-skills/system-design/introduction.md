# Systems Design

## Reading
*Don't let this reading scare you. Even at Palantir engineers aren't expected
to know all these things. If you're interested in the topic, look up
the concepts mentioned on Wikipedia.*

https://www.palantir.com/2011/10/how-to-ace-a-systems-design-interview/

A few companies will tell you to prepare for systems design problems.
The good news is this means you'll have to solve interesting problems by
considering various tradeoffs, rather than worry about finding the one
magical solution your interviewer is thinking of. The bad news is
systems design covers a broad spectrum of problems so it's hard to know
what to prepare for. On one end you may get a familiar object-oriented
design question, eg. what classes and what methods would you use to
build a tic-tac-toe game? On the other, you may be asked to architect
amazon.com on a whiteboard and talk about how you'd scale it.

Data structures are fundamental to the whole spectrum. You should know
the time and space performance characteristics of the algorithms and
data structures covered in the algorithms curriculum.

## Amazon Web Services

Companies don't use Heroku. They use AWS.  After graduation, some students have even moved their Flex or other projects to AWS to demonstrate that they're familiar with the service.   
https://d0.awsstatic.com/whitepapers/aws-overview.pdf



## OO Design

To prepare for the basic OO problems, do the following exercise. Write
the firmware for an elevator using object-oriented Ruby. Pretend that
user input comes as HTTP GET requests to /:floor-number/up or
/:floor-number/down. Start by making a bulleted list of the classes
you'll need and the methods you'll want on their instances. Extra points
if you try to optimize according to time of day.

## Architecture

Architecture is all about tradeoffs. Impress your interviewers by
showing familiarity with the typical trade-offs faced by systems
archtects.

**Latency vs. Throughput**

Latency is how long it takes you to drive from the quarry to the
construction site. Throughput (or bandwidth) is how much stone you can
take with you on each trip. It's hard to get both so you have to ask
yourself which is more important for your purposes. A Skype call needs
low latency to minimize delay when a speaker starts talking. Limited
throughput is ok since it doesn't take many bytes to carry your words
over the network. Conversely, when you're downloading a file you don't
care about latency as long as you eventually have the whole thing.

Read about how Twitter manages latency:
http://www.slideshare.net/nkallen/q-con-3770885

**At scale, component failure is the norm**

Google published a famous white paper on its file system:
http://static.googleusercontent.com/media/research.google.com/en/us/archive/gfs-sosp2003.pdf


## Bonus: Distributed Systems
* Difficulties of Distributed Systems
  * http://rajith.2rlabs.com/2008/07/23/5-reasons-why-distributed-systems-are-hard-to-develop
* Problems people face when working in distributed systems (slideshow):
  * http://static.googleusercontent.com/media/research.google.com/en/us/people/jeff/stanford-295-talk.pdf


Scalability, Availability, Stability Patterns (See
http://en.wikipedia.org/wiki/CAP_theorem)
http://www.slideshare.net/jboner/scalability-availability-stability-patterns

Scaling at eBay    
http://www.hpts.ws/papers/2009/session9/shoup.pdf
Similar but separate:
http://www.infoq.com/articles/ebay-scalability-best-practices
