#!/bin/sh

set -e

if [ "$2" = "fail" ]; then
  #java -Djava.security.egd=file:/dev/./urandom -jar /app.jar &
  sleep 10
fi

if [ "$1" = "java" ]; then
 membersrvc &
 exec /usr/local/bin/envoy -c /etc/envoy/service-envoy.json &
 echo "LOL"
fi

while true; do sleep 1000; done

exec "$@"
