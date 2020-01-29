FROM ubuntu:18.04

RUN apt-get update

RUN apt-get install -y default-jdk

RUN apt-get install -y wget 

RUN mkdir /app
WORKDIR /app
RUN wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.5.2-no-jdk-linux-x86_64.tar.gz && \
tar -xvzf elasticsearch-7.5.2-no-jdk-linux-x86_64.tar.gz
WORKDIR /app/elasticsearch-7.5.2
RUN echo "xpack.ml.enabled: false" >> config/elasticsearch.yml
RUN mkdir jdk && \
mkdir jdk/bin && \
ln -s /usr/bin/java jdk/bin/java
EXPOSE 9200
EXPOSE 9300
ENTRYPOINT ["bin/elasticsearch"]
