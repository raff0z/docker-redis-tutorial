FROM centos
RUN yum update -y && yum install -y wget telnet nano vim tcl ruby && yum group install -y "Development Tools" && gem install redis

ADD ./scripts/install.sh /tmp/install.sh
RUN chmod +x /tmp/install.sh && /tmp/install.sh
COPY ./conf/redis.conf /etc/redis/6379.conf

ADD ./scripts/install-cluster.sh /tmp/install-cluster.sh
COPY ./conf/redis-cluster.conf /tmp/redis-cluster.conf
RUN chmod +x /tmp/install-cluster.sh && /tmp/install-cluster.sh

EXPOSE 6379 30001 30002 30003 30004 30005 30006

ADD ./scripts/startup.sh /root/scripts/startup.sh
CMD ["sh","/root/scripts/startup.sh"]
