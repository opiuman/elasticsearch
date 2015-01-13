# ELK Dockerfile

----------
## start an elk instance ##
    docker run -d -p 9200:9200 -p 9300:9300 -p 5601:5601 -p 5000:5000/udp opiuman/elk

This will start an elk container with the [default configs](https://github.com/opiuman/elk/tree/master/config).

## start with persistent storage

    docker run -d -p 9200:9200 -p 9300:9300 -p 5601:5601 -p 5000:5000/udp -v <workspace-dir>:/workspace opiuman/elk
  
  The elk container will be created by mounting a workspace directory (on the host) which also contains the custom config files.

**Links to verify:**

    http://<host>:9200
    http://<host>:5601
    
