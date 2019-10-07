---
description: Manages Kafka's cluster of distributed brokers
---

# ZooKeeper

ZooKeeper manages the metadata about a cluster of distributed nodes \(brokers in the case of Kafka\).

* Communication between the nodes
* Node availability
* Membership to the cluster
* Leader election
* Leading bootstrap configuration and propagating config changes

ZooKeeper is used to elect a [Controller Broker](kafka.md#controller-broker) in the Kafka cluster. You can see the process in action by following [these steps.](https://jaceklaskowski.gitbooks.io/apache-kafka/content/kafka-demo-controller-election.html)

![](../.gitbook/assets/image%20%282%29.png)



