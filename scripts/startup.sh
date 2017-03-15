#!/bin/bash
SPORT=30000
NODES=6
EPORT=$((SPORT+NODES))

#Sart redis standalone
/etc/init.d/redis_6379 start

#Start redis cluster
while [ $((SPORT < EPORT)) != "0" ]; do
  SPORT=$((SPORT+1))
  (cd /var/redis/cluster/$SPORT && exec redis-server /var/redis/cluster/$SPORT/redis.conf)
done

/bin/bash
