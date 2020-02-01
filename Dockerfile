FROM ubuntu:18.04

RUN apt-get update

RUN apt-get install -y default-jdk

RUN apt-get install -y wget 

RUN mkdir /app
WORKDIR /app
RUN wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.5.2-no-jdk-linux-x86_64.tar.gz && \
    tar -xvzf elasticsearch-7.5.2-no-jdk-linux-x86_64.tar.gz && \
    rm -rf elasticsearch-7.5.2-no-jdk-linux-x86_64.tar.gz && \
    mv elasticsearch-7.5.2 elasticsearch
WORKDIR /app/elasticsearch
VOLUME /app/elasticsearch/data
# Config updates
# Use a k8s configmap instead
# RUN echo "xpack.ml.enabled: false" >> config/elasticsearch.yml && \
#     echo "network.host: 0.0.0.0" >> config/elasticsearch.yml && \
#     echo "bootstrap.system_call_filter: false" >> config/elasticsearch.yml && \
#     echo "discovery.seed_hosts: []" >> config/elasticsearch.yml && \
#     echo "node.master: true" >> config/elasticsearch.yml

RUN mkdir jdk && \
    mkdir jdk/bin && \
    ln -s /usr/bin/java jdk/bin/java
EXPOSE 9200
EXPOSE 9300
RUN sysctl -w vm.max_map_count=262144
ENTRYPOINT ["bin/elasticsearch"]
