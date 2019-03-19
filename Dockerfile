FROM jenkins/jnlp-slave:latest-jdk11


ENV GRADLE_VERSION=5.2.1 \
    SCALA_VERSION=2.12.8

USER root

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y --no-install-recommends install \
      python3 \
      unzip \
      wget && \
    rm -f /usr/bin/python && \
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
    apt-get -y purge \
      unzip \
      wget && \
    apt-get -y autoremove && \
    apt-get -y clean

USER jenkins

ENV PATH=$PATH:/opt/gradle/gradle-${GRADLE_VERSION}/bin:/opt/scala/scala-${SCALA_VERSION}/bin
