# Topics

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

* `--bootstrap-server` - Similar to the broker list required when producing messages to a topic this is the address of a broker from which the client can use to ‘bootstrap’. It functions as the starting point for a Kafka client to discover the full set of alive servers in the cluster. More information [Bootstrap server vs zookeeper in kafka? - Stack Overflow](https://stackoverflow.com/questions/46173003/bootstrap-server-vs-zookeeper-in-kafka)

### Viewing the log

We can now see that the messages have been written to the log:

```bash
cat /var/lib/kafka/data/my_topic-0/00000000000000000000.log
@6]mÛ,mÛ,Message1@
                  mçmçMessage2
```

