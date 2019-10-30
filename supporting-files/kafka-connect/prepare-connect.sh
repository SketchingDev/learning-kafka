#!/bin/bash

docker-compose -f ../kafka-stack-docker-compose/zk-single-kafka-single.yml exec kafka1 kafka-topics \
  --create \
  --zookeeper zoo1:2181 \
  --replication-factor 1 \
  --partitions 1 \
  --if-not-exists \
  --topic my-connect-config
  
docker-compose -f ../kafka-stack-docker-compose/zk-single-kafka-single.yml exec kafka1 kafka-topics \
  --create \
  --zookeeper zoo1:2181 \
  --replication-factor 1 \
  --partitions 1 \
  --if-not-exists \
  --topic my-connect-offsets 
  
docker-compose -f ../kafka-stack-docker-compose/zk-single-kafka-single.yml exec kafka1 kafka-topics \
  --create \
  --zookeeper zoo1:2181 \
  --replication-factor 1 \
  --partitions 1 \
  --if-not-exists \
  --topic my-connect-status
