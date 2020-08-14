#! /usr/bin/env bash
cd `dirname $0`

docker build -t 10.22.1.232:8089/boco/alpine-kafka:1.0.1 .
docker push 10.22.1.232:8089/boco/alpine-kafka:1.0.1
docker tag 10.22.1.232:8089/boco/alpine-kafka:1.0.1 boco/alpine-kafka:1.0.1
docker save boco/alpine-kafka:1.0.1 | gzip > docker_alpine_kafka_1.0.1.tar.gz
docker rmi 10.22.1.232:8089/boco/alpine-kafka:1.0.1
docker rmi boco/alpine-kafka:1.0.1