#
# Supervisoring Elasticsearch, Marvel and Kibana
#
#

# Pull base image.
FROM dockerfile/java:oracle-java7
MAINTAINER wangwscn@hotmail.com

ENV ES_PKG_NAME elasticsearch-1.4.1
ENV KIB_PKG_NAME kibana-4.0.0-beta3

#Install supervisor & nginx.
RUN apt-get update && apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

# Install ElasticSearch.
RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch

#Install Kibana.
RUN \
  cd / && \
  wget https://download.elasticsearch.org/kibana/kibana/$KIB_PKG_NAME.tar.gz && \
  tar xvzf $KIB_PKG_NAME.tar.gz && \
  rm -f $KIB_PKG_NAME.tar.gz && \
  mv /$KIB_PKG_NAME /kibana

# Define mountable directories.
VOLUME ["/data"]

# Mount config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY config/kibana.yml /kibana/config/kibana.yml

# Define working directory.
WORKDIR /data

#Install marvel
RUN /elasticsearch/bin/plugin -i elasticsearch/marvel/latest

# Define default command.
CMD ["/usr/bin/supervisord"]

# Expose ports - 9200: HTTP,- 9300: transport, - 5601: HTTP.
EXPOSE 9200 9300 5601