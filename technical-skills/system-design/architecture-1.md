# Web Architecture (Part I)

### Basic Configuration of a Web App
![basic-setup](https://assets.aaonline.io/fullstack/job-search/technical-skills/system-design/images/00-basic-setup.jpg)

The above image represents a simple set up of a web app. Let's imagine that we 
have a toy app called myfacebook.com. Let's observe how this app is set up:

1. When the user goes to the browser and types in "www.myfacebook.com", it 
instantiates a DNS lookup (provided by browser, OS, ISP) to find the correct IP 
address to find the correct machine and get the website associated with that 
domain (you can think of DNS as a phone book for the internet).

```
Quick Aside:
HTTP vs. TCP

HTTP is protocol for communication (e.g., a language)
TCP is the medium by which servers communicate (e.g., the phone)

HTTP is built on top of the TCP protocol.
```

2. Then, your machine opens a TCP (transmission control protocol) connection 
via HTTP request to a web server (typically Puma; maybe Webrick in development). 
The web server's only job is to speak HTTP.

3. The web server does some processing on the request and hands it off to the 
application (Rails, Sinatra) using Rack. The application then determines 
what to put in the body of the response back to the user.

4. Meanwhile, there's also a database server running (PostgreSQL in this 
example). The application talks to the database through a TCP connection. (Conceivably, 
the application and database servers could live on different machines, but for 
this simple set up, let's assume that they exist on the same machine.) The 
application sends SQL for the database to execute, and then the database sends 
the response back.

5. As the database executes the SQL, it makes read and write operations to the 
RAM (Random-access memory) and hard disk of the machine based on the SQL that 
the application sends. RAM is fast to read and write from, but it does not 
persist once the machine is turned off. On the other hand, data in the hard disk 
does persist, but operations are much slower. When you grab data, if it doesn't
already exist in the RAM, then it goes to the disk, goes to the RAM, and then
back to the database.

### Basic App Performance
Let's analyze the performance of our basic web app, myfacebook.com, which was 
built on Rails and uses a PostgreSQL database.

#### Application (Rails)
In general, Ruby excutes slowly in comparison to other languages like C and Java.

One way you could boost the performance of your app is to configure Ruby to use 
the JRuby interpreter (which is written in Java) instead of its default MRI 
interpreter (which is written in C). JRuby is advantageous because it can run 
Ruby code in parallel (multi-threaded), and it can run Ruby code quicker. At the 
same time, one of the main downsides of JRuby is the slower start up time 
compared to MRI.

#### Web Server
Two common servers includes Webrick and Puma. Webrick is designed to be simple, 
and it's single-threaded. Single-threaded means if there are two requests, then 
the first one must finish executing before the second one can be handled. 
Therefore, it's quite slow and can only handle around 100 requests per second.

Puma, in contrast, is multi-threaded and can handled multiple requests at the 
same time. It's much faster than Webrick and can handle around 2k requests per 
second.

How Puma's multi-threading works:
![puma threads](https://assets.aaonline.io/fullstack/job-search/technical-skills/system-design/images/01-threads.jpg)

##### Quick Aside: Different Models of Multi-Programming (Parallel vs. Concurrent)
**From [Quora][parallel-concurrent]**

[parallel-concurrent]: https://www.quora.com/What-is-the-difference-between-concurrency-and-parallelism

![brick walls](https://assets.aaonline.io/fullstack/job-search/technical-skills/system-design/https://assets.aaonline.io/fullstack/job-search/technical-skills/system-design/images/brick-walls.png)

**Problem**: You have to build two parallel brick walls. You have to carry the pile 
of bricks with you as you move along building the two walls.

**Naive Solution**: Build one wall. Go back to the start point. Build the other 
wall. It is simple to see how this isn't efficient. You'll be carrying the 
bricks along with you till the end, and then move them back to the start point.

**Concurrency**: Lay down one column of bricks of one wall, and then move to the 
other wall. When two corresponding columns of the two walls are built, move to 
the next column. This is a lot more efficient, since by the time you reach the 
end, you will be done, and the effort of carrying the pile of bricks from one 
end back to the start, will not be required.

**Parallelism**: Hire another brick layer who works alongside you on the second 
wall, while you are working on the first wall. This is obviously the best model, 
since it essentially reduces time to lay the bricks by half. However, it does 
require an extra brick layer.

**Parallelism vs. Concurrency**: Both are models of multi-programming.

Concurrency is essentially when two tasks are being performed at the same time. 
This might mean that one is 'paused' for a short duration, while the other is 
being worked on. Importantly, a different task is begun before an ongoing task 
is completed. This makes it a multi-programming model.

Parallelism requires that at least two processes/tasks are actively being 
performed at a particular moment in time. As illustrated by the metaphor above, 
this means that you require at least two 'processors' or 'workers'.

**The number of tasks actively being completed/performed at any instance of time, is what differentiates the two models.**

#### Database (PostgreSQL)
Databases in general have very high read rates. PostgreSQL can make 
approximately 80k reads per second (only applies if the data is residing in the 
RAM). However, the write rate is much slower (about 2.5k writes per second for 
solid state disks; rotational drives is even slower). This is because PostgreSQL 
always needs to write to disk to achieve durability. When a machine is booted 
up, it stores as much of the data from the hard disk to the RAM as possible to 
improve the read performance.

### Scaling
Let's say our app, myfacebook.com, starts to grow in popularity, and our current 
configuration can no longer handle the larger amounts of requests. What can we 
do?

#### Scaling up
The first option that we should always explore is **scaling up**, which is to 
make our machine more powerful. There are different ways to improve:
* Add more CPUs, faster CPUs, or CPUs with more cores. Think of adding a CPU 
core like adding another worker. Specifically, this would improve application 
server and database performance.
* Add more RAM. This would especially improve database read performance because 
it would allow for more data to be held in the RAM.
* Replace rotational disks with solid state disks, which would especially 
improve database write performance.

These improvements to the machine would only cost money and not require you to 
reconfigure the way your system is actually set up. This should be the first 
option explored because it's much better than needing to sink time into 
reconfiguring your infrastructure.

#### Scaling out
Once we've maxed out how powerful our one machine can be, the next step to 
explore is **scaling out**.

![scaling out](https://assets.aaonline.io/fullstack/job-search/technical-skills/system-design/images/02-app-tier.jpg)

In this first implementation of scaling out, we would add more machines and 
distribute the work of the application server. Notice that we would not yet 
distribute the work of the database across multiple machines, but it does now 
have its own dedicated machine.

In this configuration, the user would still send out the HTTP request, but this 
time it first hits a load balancer (ie. NGINX), which distributes the work 
across the machines.

If you run your application servers on three different machines, then the load 
balancer would send approximately a third of requests to each one. All three 
machines are essentially clones of each other. Theoretically, you can now do 3 
times the work you could before.

In terms of cost, the database box(machine) is typically very high-end and 
expensive since it's doing much heavier work. The application server machines, 
on the other hand, are less expensive because it's more cost-efficient to run 
more cheap boxes than a few expensive boxes.

---

DB can save data from both disk and RAM
-disk (permanent, persistent)
-RAM (staging area, fast reading, volatile)

elastic compute cloud (EC2)
-lets you rent a box (machine) in AWS data center
-get AWS-specific domain name
-configure nameserver to identify this domain with your own (CNAME record)

rails
-written in ruby, which can execute slowly (can use jruby to make it faster)
-webrick is simple and slow
-puma is multithreaded and fast

postgresql
-very high read rates (if data is in RAM)
-lower write rates (needs to write to disk)

CPU only speaks assembly
compilation
-program written in assembly which takes in code and translates to assembly
-outputs binary assembly instructions, saves as executable
-can then run exe
-compiler is a translator

interpretation
-interpreter can be written in compiled language
-simultaneous translation
-as it sees interpreted language, it will immediately tell the CPU what the assembly is

MRI - single threaded, default ruby interpreter
JRuby - multithreaded

CPU core
-1 core: single worker. could go faster and faster but only one
-more cores: more workers. in parallel. multithreaded

improving performance:

scaling up (more powerful, better equipment)
-more CPUs, faster CPUs, more cores (improves app server and DB server)
-more RAM (improves DB read performance)
-use SSD over rotational disks, use RAID (improves DB write performance)

scaling out (more machines)
-more app servers (app tier)
-NGINX in its own box
-DB box is typically very high-end and expensive
-app machines are low-end and inexpensive

heroku dyno: app server. more dynos, more app servers

distributed application server
-run identical copies of app server on multiple machines
-load balancer (NGINX) distributes work to multiple machines
-NGINX is a reverse proxy, it obscures machines with the web service
-DB is running on another machine, all app servers connect to it
-application tier has multiple machines, DB tier doesn't

database constraints are important because a distribution system can pass 
validations but then send conflicting requests to the DB
most databases run queries in parallel

increasing number of app machines doesn't distribute load on a DB server
-read load is greater than write load
-distributing read load is a huge win
