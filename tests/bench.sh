#!/usr/bin/env bash
echo 'sleep for 20s...'
sleep 20
echo 'stream with 10 cr# starts:'
ab -n 50000 -c 10 http://172.24.42.229/

echo 'sleep for 20s...'
sleep 20
echo 'stream with 20 cr# starts:'
ab -n 50000 -c 20 http://172.24.42.229/

echo 'sleep for 20s...'
sleep 20
echo 'stream with 30 cr# starts:'
ab -n 50000 -c 30 http://172.24.42.229/

echo 'sleep for 20s...'
sleep 20
echo 'stream with 40 cr# starts:'
ab -n 50000 -c 40 http://172.24.42.229/

echo 'sleep for 20s...'
sleep 20
echo 'stream with 50 cr# starts:'
ab -n 50000 -c 50 http://172.24.42.229/

echo 'sleep for 20s...'
sleep 20
echo 'stream with 100 cr# starts:'
ab -n 50000 -c 100 http://172.24.42.229/

echo 'sleep for 20s...'
sleep 20
echo 'stream with 200 cr# starts:'
ab -n 50000 -c 200 http://172.24.42.229/

echo 'sleep for 20s...'
sleep 20
echo 'stream with 500 cr# starts:'
ab -n 50000 -c 500 http://172.24.42.229/

echo 'sleep for 20s...'
sleep 20
echo 'stream with 1000 cr# starts:'
ab -n 50000 -c 1000 http://172.24.42.229/


