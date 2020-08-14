FROM coolbeevip/docker-alpine-jre:1.8

MAINTAINER coolbeevip <coolbeevip@gmail.com>

ENV KAFKA_VERSION=2.5.0
ENV SCALA_VERSION=2.12
ENV KAFKA_HOME=/kafka
ENV KAFKA_TAR=kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

ENV PATH=${PATH}:${KAFKA_HOME}/bin

COPY start-kafka.sh broker-list.sh create-topics.sh /tmp/

RUN apk add --update docker jq coreutils \
 && chmod a+x /tmp/*.sh \
 && mv /tmp/start-kafka.sh /tmp/broker-list.sh /tmp/create-topics.sh /usr/bin \
 && sync \
 && wget -q https://downloads.apache.org/kafka/${KAFKA_VERSION}/${KAFKA_TAR} \
 && tar xfz ${KAFKA_TAR} \
 && mv kafka_${SCALA_VERSION}-${KAFKA_VERSION} /kafka \
 && rm -rf ${KAFKA_TAR} \
 && rm -rf /tmp/*

VOLUME ["/kafka"]

# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
CMD ["start-kafka.sh"]
