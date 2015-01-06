#
# Supervisoring Elasticsearch, Marvel and Kibana
#
#

# Pull base image.
FROM dockerfile/java:oracle-java7
MAINTAINER wangwscn@hotmail.com

ENV ES_PKG_NAME elasticsearch-1.4.1
ENV KBA_PKG_NAME kibana-3.1.1

#Install supervisor & nginx.
RUN apt-get update && apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
RUN apt-get install -y nginx-full wget
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

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
  wget https://download.elasticsearch.org/kibana/kibana/$KBA_PKG_NAME.tar.gz && \
  tar xvzf $KBA_PKG_NAME.tar.gz && \
  rm -f $KBA_PKG_NAME.tar.gz && \
  mv /$KBA_PKG_NAME/* /usr/share/nginx/html

# Define mountable directories.
VOLUME ["/data"]

# Mount config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY config/config.js /usr/share/nginx/html/config.js

# Define working directory.
WORKDIR /data

#Install marvel
RUN /elasticsearch/bin/plugin -i elasticsearch/marvel/latest

# Define default command.
CMD ["/usr/bin/supervisord"]

# Expose ports - 9200: HTTP,- 9300: transport, - 80 nginx.
EXPOSE 9200 9300 80