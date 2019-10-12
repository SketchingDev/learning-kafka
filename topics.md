# Topics

Broker reads/writes to a log file



### Partitions

Partitions are what make publishing messages to a Kafka topic scalable, since they split the work of maintaining a commit log \(where messages are stored per offset\) for each topic across multiple brokers. Since the physical commit log for a topic is a 'partition' it means every topic will have at least one partition.

When a producer then wants to publish a message to the 

* Physical log file = partition
* A partition cannot be split across hosts
* A topic must have at least one partition
* Offsets are stored per topic:partition for each group of consumers \(Group ID\). Interestingly the committed offset for each group is stored on a topic 
  * \`kafka-console-consumer --bootstrap-server kafka1:9092 --topic \_\_consumer\_offsets --from-beginning\`

"In general, the scalability of Kafka is determined by the number of partitions being managed by multiple broker nodes"

The offset increases independently per partition, so a consumer might receive the messages out of order

### Useful links

* [https://stackoverflow.com/questions/38024514/understanding-kafka-topics-and-partitions](https://stackoverflow.com/questions/38024514/understanding-kafka-topics-and-partitions)

### Exploring via CLI

These commands are from following a PluralSight course, although they’re performed in more detail in [Kafka’s Getting Started section](https://kafka.apache.org/quickstart).

### Start Zookeeper and a Kafka broker locally

```bash
docker-compose -f zk-single-kafka-single.yml exec kafka1 bash
```

### Creating a topic

```bash
kafka-topics --create --topic my_topic --zookeeper zoo1:2181 --replication-factor 1 --partitions 1
```

* `--zookeeper` - Zookeeper is responsible for assigning a broker to be responsible for the topic

In the logs for the broker you can see it create a log directory for the topic. This is the physical storage for the logical construct of a ‘topic’.

```text
> broker_1     | [2019-10-05 12:29:10,846] INFO Created log for partition my_topic-0 in /var/lib/kafka/data with properties {compression.type -> producer, message.format.version -> 2.0-IV1, file.delete.dela
...
```

### Listing topics

```bash
kafka-topics --list --zookeeper zoo1:2181
```

### Producing to a topic

```bash
kafka-console-producer --broker-list kafka1:9092 --topic my_topic
> Message1
> Message2
```

### Consuming a topic

```bash
kafka-console-consumer --bootstrap-server kafka1:9092 --topic my_topic --from-beginning
Message1
Message2
```

* `--bootstrap-server` - Similar to the broker list required when producing messages to a topic this is a delimited list of addresses of brokers which the client can use to ‘bootstrap’ its configuration. It functions as the starting point for a Kafka client to discover the full set of alive servers in the cluster. More information [Bootstrap server vs zookeeper in kafka? - Stack Overflow](https://stackoverflow.com/questions/46173003/bootstrap-server-vs-zookeeper-in-kafka)

### Viewing the log

We can now see that the messages have been written to the log:

```bash
cat /var/lib/kafka/data/my_topic-0/00000000000000000000.log
@6]mÛ,mÛ,Message1@
                  mçmçMessage2
```

