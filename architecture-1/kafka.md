# Kafka ecosystem

![](../.gitbook/assets/41853aed-98cc-4beb-9734-5e3e0729178c.png)

Designed to handle:

* high-throughput to support high volume event streams such as real-time log aggregation
* handle low-latency delivery to handle more traditional messaging use-cases
* be able to guarantee fault-tolerance in the presence of machine failures.



Kafka has three main parts:

### Producer

Producers put messages onto one or more Kafka topics

* Producer can decide on the binary payload of the message
* Designed to be loosely coupled
* Can produce messages at their own rate 

### Consumer

* Can consume messages at their own rate
* Designed to be loosely coupled

### Message

Sent by the producer to a topic or consumed by the consumer from a topic

* Timestamp - set by broker
* ID - set by broker based on previous offset
* Payload - Binary data based on application's protocol e.g. Avro

### Brokers

* Building block of Kafka cluster
* Distributed across many brokers
* Also known as a 'server' or 'node'
* Receives messages from Producers and stored them on disk keyed by unique offset
* Allows consumers to fetch messages by topic, partition and offset
* Every cluster has exactly one broker that is designated as the Controller
* Flexible publish-subscribe semantics

#### Controller Broker

A controller broker is an important broker within the Kafka ecosystem that is elected by Zookeepers leader election process. The controller forms the leader-follower hierarchy of brokers within the Kafka ecosystem.



