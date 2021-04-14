# Kafka Connect

* [Quick Start - Write data from Kafka to a file](https://docs.confluent.io/current/connect/quickstart.html#write-file-data-with-kconnect)
* [Installing Kafka Connect via Docker](https://docs.confluent.io/5.0.0/installation/docker/docs/installation/connect-avro-jdbc.html)
* [Kafka Connect Deep Dive – Converters and Serialization Explained](https://www.confluent.io/blog/kafka-connect-deep-dive-converters-serialization-explained)
* [Create a Docker Image containing Local Connectors](https://docs.confluent.io/current/connect/managing/extending.html#create-a-docker-image-containing-local-connectors)

Connect stores config, status, and offsets of the connectors in Kafka topics. These topics need to be created manually.

_I don't think that this is necessary. It appears as if Kafka Connect will create the topics for you._

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

Run a \[file sink connector\]\([https://docs.confluent.io/current/connect/filestream\_connector.html](https://docs.confluent.io/current/connect/filestream_connector.html)\) \(run from inside Connect container\):

```bash
curl -X POST \
  http://localhost:28083/connectors \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "local-file-sink",
    "config": {
        "connector.class": "FileStreamSink",
        "tasks.max": "1",
        "file": "/tmp/test.sink.txt",
        "topics": "my_topic"
    }
}'
```

See the status of the connector:

```bash
curl http://localhost:28083/connectors/local-file-sink/status
```

```text
root@kafka1:/# kafka-console-producer --broker-list kafka1:9092 --topic my_topic
>{"schema": {"type":"struct","fields": [{"type": "string","optional": false,"field": "name"}],"optional": false,"name": "ksql.users"},"payload": {"name": "bob"}}
```



