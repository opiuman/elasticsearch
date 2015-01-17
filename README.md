# ELK Dockerfile

----------
## start an elk instance ##
    docker run -d -p 9200:9200 -p 9300:9300 -p 5601:5601 -p 5000:5000/udp opiuman/elk

This will start an elk container with the [default configs](https://github.com/opiuman/elk/tree/master/config).

## start with persistent storage

    docker run -d -p 9200:9200 -p 9300:9300 -p 5601:5601 -p 5000:5000/udp -v <workspace-dir>/workspace:/workspace opiuman/elk
  
  The elk container will be running with a mounted workspace directory (on the host) which could contain the custom config files (elasticsearch.yml, kibana.yml, logstash.conf and supervisord.conf) if you want to run with your own settings. Put the custom index templates under folder /workspace/config/templates.

**Links to verify:**

    http://<host>:9200
    http://<host>:5601
    
