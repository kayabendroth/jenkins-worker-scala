FROM jenkins/jnlp-slave:3.19-1-alpine


ENV GRADLE_VERSION=4.7 \
    SCALA_VERSION=2.12.6

USER root

RUN apk update && \
    apk upgrade && \
    apk add \
      python3 \
      unzip \
      wget && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    cd /tmp && \
    wget -O gradle-${GRADLE_VERSION}-bin.zip https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    mkdir -p /opt/gradle && \
    unzip -d /opt/gradle gradle-${GRADLE_VERSION}-bin.zip && \
    rm -f gradle-${GRADLE_VERSION}-bin.zip && \
    mkdir -p /opt/scala && \
    wget https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz && \
    tar xzf scala-${SCALA_VERSION}.tgz -C /opt/scala && \
    rm -f scala-${SCALA_VERSION}.tgz && \
    apk del \
      unzip \
      wget

USER jenkins

ENV PATH=$PATH:/opt/gradle/gradle-${GRADLE_VERSION}/bin:/opt/scala/scala-${SCALA_VERSION}/bin
