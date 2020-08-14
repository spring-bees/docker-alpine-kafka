coolbeevip/docker-alpine-kafka
============

docker-compose.yml

```yaml
version: '3.2'
services:
  nc-zookeeper:
    image: coolbeevip/docker-alpine-zookeeper
    hostname: nc-zookeeper
    container_name: nc-zookeeper
    restart: always
    networks:
      - nc-network
    ports:
      - 2181:2181
  nc-kafka:
    image: coolbeevip/docker-alpine-kafka
    hostname: nc-kafka
    container_name: nc-kafka
    restart: always
    networks:
      - nc-network
    ports:
      - 9092:9092
    environment:
      - KAFKA_ADVERTISED_HOST_NAME=10.0.0.20
      - KAFKA_CREATE_TOPICS=test:1:1
      - KAFKA_ZOOKEEPER_CONNECT=nc-zookeeper:2181
networks:
  nc-network:
    external: true

```

* 修改docker-compose.yml中的 KAFKA_ADVERTISED_HOST_NAME 以匹配您的 docker 主机IP（注意：如果要运行多个代理，请不要使用localhost 或 127.0.0.1 作为主机ip）

* 自动创建 Topic 格式 KAFKA_CREATE_TOPICS: <topic>:<partition>:<replicas>

* 如果您想自定义任何Kafka参数，只需将它们作为环境变量添加到 `docker-compose.yml' 中即可，例如 为了增加 `message.max.bytes` 参数，将环境设置为 `KAFKA_MESSAGE_MAX_BYTES：2000000`。 要关闭自动主题创建，请设置  `KAFKA_AUTO_CREATE_TOPICS_ENABLE：false`

* Kafka的 log4j 用法可以通过添加以 `LOG4J_` 为前缀的环境变量来定制。 这些将被映射到 `log4j.properties`。 例如：`LOG4J_LOGGER_KAFKA_AUTHORIZER_LOGGER = DEBUG，authorizerAppender`

## 启动

`docker-compose up -d`

## 停止

`docker-compose stop`
