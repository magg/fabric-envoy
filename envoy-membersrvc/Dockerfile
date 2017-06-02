FROM hyperledger/fabric-membersrvc:x86_64-0.6.1-preview

COPY membersrvc.yaml ./membersrvc

ADD ./envoy /usr/local/bin/envoy
RUN apt-get update && apt-get install -y build-essential
RUN strip /usr/local/bin/envoy
RUN apt-get purge -y build-essential
RUN mkdir -p /etc/envoy
ADD ./service-envoy.json /etc/envoy

COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD /start.sh java fail
