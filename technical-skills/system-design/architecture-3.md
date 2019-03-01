ACID
A - atomicity (all of a transaction is saved, or none of it is)
C - consistency (declared constraints will not be violated)
I - isolation (transactions performed in serial order)
D - durability (data acknowledged as saved will not be lost, database will never enter a corrupted, unrecoverable state)

sharding breaks ACID
transactions can write to different shards and could lead to conflicting data (e.g., one transaction squares everything, one doubles, which one gets applied first to what shard?)
loss of atomicity

leader/follower doesn't break ACID because leader sends changes to followers in serial order

serializability
-even though transactions may be processed in parallel for performance reasons, result is as if they were a single thread
-must sometimes abort a conflicting transaction

two phase locking
-lock the database while one transaction is happening
-row gets locked as it is read or written
-when the transaction is complete, locks are released and another transaction can go through
-abort if there's a conflict

two phase commit (more meta than two phase locking, at distributed systems level)
cat adoption service
-pair of cats is great, alone cat is awful
-either both or none

shelters are shards, cats are rows
-if you want cats from both shelters, shelter 1 says okay, shelter 2 says they've already adopted away the cat
-results in only one cat. bad

instead:
tell both shelters to hold the cats
shelters confirm the hold
hold must be indefinite
if you hear one is unavailable, transaction aborted
if you hear both are available, transaction committed

shelter failure
eventually timeout and tell the client the cats are unavailable
tell shelters to release hold. give up
if one shelter goes down, client must wait until it comes back up

coordinator failure
if shelter 1 shipped the cat, shelter 2 must as well. shelters can talk to each other
client doesn't know that the shelters have shipped (submarine write)

if coordinator and site become unavailable at same time, some records might be locked indefinitely until the site comes back up
the site that's up can't even talk to the other site

2PC ensures
-both sites either commit or rollback
-if client is told the transaction succeeded, it did
-only 2 round trips of communication

availability issues pop up with 2PC
-if one part fails, hold is indefinite
-especially possible if shards live in different datacenters in different locations
-it sucks if one part failing means other parts will fail

latency
-shards close to geographical location
-loss of connectivity between datacenters can cause lockups with 2PC
-latency between datacenters is high, the longer locks are held the greater likelihood of congestion
-availability and latency degrade the service and can have real costs

failover
-detecting that the leader has failed and making sure that only one person becomes the new leader
-automatic failover is better than manual. manual not scalable

other distributed transaction protocols
-algos like paxos, zab, and raft eliminate the coordinator as a single point of failure
-distribute the role of transaction manager via election when coordinator is suspected dead
-in case of tie, there will be a timeout and a new election
-still suffer from high latencies between datacenters
-still can hang a transaction if there are partitions

CAP theorem
impossible for a distributed system to simultaneously provide:
-consistency (only one leader)
-availability (every site up)

availability but not consistency (multi-master replication)
-leaders in both partitions
-each partition gets written to separately, but can communicate with each other
-this communication takes time so there are times when the partitions have inconsistent data
-partition doesn't rely on another partition so it can act quickly
-if one partition loses power, the other partition can take over (but the users using one partition will see more latency)

trying to lock for consistency means that there is congestion and you lose availability

without distributed transactions
-inconsistency might be temporarily visible, but all sites will eventually reflect the update

idempotency (something applied twice to any value gives same result as if it were applied once)
-two counters should always be incremented together
-okay if temporarily unequal, but should eventually resolve
-if only A confirms, did B fail to confirm or fail to increment?
-messages lack idempotency -- can't safely resend them because might perform action twice

any operation can be made idempotent with a unique token
receiver remembers token
receiver can see if it's seen a token before processing
