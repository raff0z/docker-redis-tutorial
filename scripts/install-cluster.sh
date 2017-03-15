#!/bin/bash
set -x

SPORT=30000
NODES=6
EPORT=$((SPORT+NODES))

mkdir -p /var/redis/cluster

CHOSTS=""

while [ $((SPORT < EPORT)) != "0" ]; do
  SPORT=$((SPORT+1))
  mkdir /var/redis/cluster/$SPORT
  cp /tmp/redis-cluster.conf /var/redis/cluster/$SPORT/redis.conf
  sed -i "s/^port.*/port $SPORT/g" /var/redis/cluster/$SPORT/redis.conf
  CHOSTS="$CHOSTS 127.0.0.1:$SPORT"
  (cd /var/redis/cluster/$SPORT && exec redis-server /var/redis/cluster/$SPORT/redis.conf)
done

/root/downloads/redis-stable/src/redis-trib.rb create --replicas 1 $CHOSTS <<< $"yes"
