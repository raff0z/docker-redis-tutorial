#!/bin/bash
curdir=$PWD

mkdir /root/downloads
cd /root/downloads
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
# make test
make install
mkdir /etc/redis
mkdir /var/redis
cp ./utils/redis_init_script /etc/init.d/redis_6379
mkdir /var/redis/6379

cd $curdir;
