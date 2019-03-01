# Web Architecture (Part II)

### Scaling out database reads
In the previous section, we discussed scaling out the application tier. In that implementation, the work of the application server can be distributed across as many machines as possible. However, because the database server is still only running on one machine, the database eventually ends up becoming the limiting factor.

Since many web apps have much more database reads than writes, let's first explore how to scale out the reads.

![leader follower databases](https://assets.aaonline.io/fullstack/job-search/technical-skills/system-design/images/03-leader-follower-replication.jpg)

In this implementation, let's say that we have 3 application servers, just like before, but now we also have 3 database machines. Of the 3 database machines, one of them is the leader, and **all** of the write operations go to the leader.

Once a write operation is executed by the leader, the leader sends logs, which is a compressed history of the changes, to the 2 follower databases. This keeps the other 2 databses up-to-date with the leader, which then allows the read operations from the application servers to be distributed evenly across all 3 database machines. In summary, the followers don't see queries; rather, they just see the effects of the queries from the logs.

One additional benefit of this configuration is that the followers also serves a backups, which increases overall durability.

### Distributing write load
In the above implementation,
sharding
-creates complexity
-split up data across n machines
-data is typically partitioned by hash of primary key % n
-point queries distributed across shards
-ideal for transactions that only read/write a single row

joins are not scalable
-would need to look at every shard to do a join

denormalize database
-add redundancies into database
-denormalizing selectively results in higher performance
e.g., if you're looking for friend count, having a count column on a user plus the regular joins makes the count query fast
e.g., friends table with user_id and array of friends
-difficult to keep data up to date -- if user name changes, must change all their friend's rows in every shard
-worth extra effort if name doesn't change that often

benefits of normalization
-easier to maintain
-less space
