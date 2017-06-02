# Dockerfile for Hyperledger peer image. This actually follow yeasy/hyperledger-fabric
# image and add default start cmd.
# Data is stored under /var/hyperledger/db and /var/hyperledger/production


FROM golang:1.7
MAINTAINER Baohua Yang

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
        && apt-get install -y libsnappy-dev zlib1g-dev libbz2-dev \
        && rm -rf /var/cache/apt

# install rocksdb
RUN cd /tmp \
        && git clone --single-branch -b v4.1 --depth 1 https://github.com/facebook/rocksdb.git \
        && cd rocksdb \
        && PORTABLE=1 make shared_lib \
        && INSTALL_PATH=/usr/local make install-shared \
        && ldconfig \
        && rm -rf /tmp/rocksdb

RUN mkdir -p /var/hyperledger/db \
        && mkdir -p /var/hyperledger/production

# clone fabric 0.6 code to local
RUN mkdir -p $GOPATH/src/github.com/hyperledger \
        && cd $GOPATH/src/github.com/hyperledger \
        && git clone --single-branch -b v0.6 --depth 1 http://gerrit.hyperledger.org/r/fabric \
        && cp $GOPATH/src/github.com/hyperledger/fabric/devenv/limits.conf /etc/security/limits.conf

WORKDIR $GOPATH/src/github.com/hyperledger/fabric

# this is only a workaround for current hard-coded problem when using as fabric-baseimage.
RUN ln -s $GOPATH /opt/gopath


# install hyperledger peer and membersrvc
RUN cd $GOPATH/src/github.com/hyperledger/fabric/peer \
         && CGO_CFLAGS=" " CGO_LDFLAGS="-lrocksdb -lstdc++ -lm -lz -lbz2 -lsnappy" go install \
         && cp $GOPATH/src/github.com/hyperledger/fabric/peer/core.yaml $GOPATH/bin \
         && go clean



ADD ./envoy /usr/local/bin/envoy
RUN apt-get update && apt-get install -y build-essential
RUN strip /usr/local/bin/envoy
RUN apt-get purge -y build-essential
RUN mkdir -p /etc/envoy
ADD ./vp3-envoy.json /etc/envoy

COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD /start.sh java fail
