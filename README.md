# ELK Dockerfile

 - Default usage:

    docker run --rm -p 9200:9200 -p 9300:9300 -p 5601:5601 -p 5000:5000 opiuman/elk

 - Mount with your configs:

    docker run --rm -p 9200:9200 -p 9300:9300 -p 5601:5601 -p 5000:5000 -v [your local dir]:/workspace opiuman/elk
