#!/bin/sh

set -e

if [ "$2" = "fail" ]; then
  #java -Djava.security.egd=file:/dev/./urandom -jar /app.jar &
  sleep 10
fi

if [ "$1" = "java" ]; then
 sleep 10; peer node start &
 exec /usr/local/bin/envoy -c /etc/envoy/vp3-envoy.json --service-cluster ${CORE_PEER_ID} --service-node ${CORE_PEER_ID} &
 echo "LOL"
fi

while true; do sleep 1000; done

exec "$@"
