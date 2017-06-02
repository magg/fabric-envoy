FROM node:argon

# Install required prereqs.
RUN apt-get -y update && apt-get -y install netcat
ADD ./envoy/envoy /usr/local/bin/envoy
RUN apt-get update && apt-get install -y build-essential
RUN strip /usr/local/bin/envoy
RUN apt-get purge -y build-essential
RUN mkdir -p /etc/envoy
ADD ./front-proxy.json /etc/envoy

# Create app directory
RUN mkdir -p /usr/src/app
VOLUME /tmp

WORKDIR /usr/src/app

# Update npm
RUN npm install -g npm

# Install app dependencies
COPY SDK-Demo/package.json /usr/src/app/
RUN npm install --quiet

# Bundle app source
COPY SDK-Demo/ /usr/src/app/SDK-Demo/
RUN sh -c 'chmod 777 SDK-Demo/us.blockchain.ibm.com.cert'

CMD ["sh", "./SDK-Demo/Scripts/docker-startup.sh"]
