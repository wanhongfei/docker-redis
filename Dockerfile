FROM wanhongfei/base:latest

MAINTAINER wwhhff11 "1272700372@qq.com"

### base software
RUN mkdir -p /home/software

### redis
ADD /redis/redis-3.2.8.tar.gz /home/software/
RUN mkdir -p /home/software/redis-3.2.8/bin
ADD /redis/redis.conf /home/software/redis-3.2.8/bin/
RUN cd /home/software/redis-3.2.8 && make && make install

RUN mv /home/software/redis-3.2.8/src/redis-benchmark /home/software/redis-3.2.8/bin/redis-benchmark
RUN mv /home/software/redis-3.2.8/src/redis-cli /home/software/redis-3.2.8/bin/redis-cli
RUN mv /home/software/redis-3.2.8/src/redis-server /home/software/redis-3.2.8/bin/redis-server

ENV REDIS_HOME=/home/software/redis-3.2.8
ENV PATH=$PATH:$REDIS_HOME/bin

### port 6379
EXPOSE 6379

### startup
ENTRYPOINT ["/home/software/redis-3.2.8/bin/redis-server", "/home/software/redis-3.2.8/bin/redis.conf"]