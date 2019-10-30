# Kafka Connect

* \[Quick Start - Write data from Kafka to a file\]\([https://docs.confluent.io/current/connect/quickstart.html\#write-file-data-with-kconnect](https://docs.confluent.io/current/connect/quickstart.html#write-file-data-with-kconnect)\)
* \[Installing Kafka Connect via Docker\]\([https://docs.confluent.io/5.0.0/installation/docker/docs/installation/connect-avro-jdbc.html](https://docs.confluent.io/5.0.0/installation/docker/docs/installation/connect-avro-jdbc.html)\)

Connect stores config, status, and offsets of the connectors in Kafka topics. These topics need to be created manually.

```text
#!/bin/bash

docker-compose -f zk-single-kafka-single.yml exec kafka1 kafka-topics \
  --create \
  --zookeeper zoo1:2181 \
  --replication-factor 1 \
  --partitions 1 \
  --if-not-exists \
  --topic my-connect-config
  
docker-compose -f zk-single-kafka-single.yml exec kafka1 kafka-topics \
  --create \
  --zookeeper zoo1:2181 \
  --replication-factor 1 \
  --partitions 1 \
  --if-not-exists \
  --topic my-connect-offsets 
  
docker-compose -f zk-single-kafka-single.yml exec kafka1 kafka-topics \
  --create \
  --zookeeper zoo1:2181 \
  --replication-factor 1 \
  --partitions 1 \
  --if-not-exists \
  --topic my-connect-status 

```

