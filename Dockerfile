FROM dockerfile/java
MAINTAINER Mikael Sennerholm <mikael@sennerholm.net>
# Partly from: https://github.com/gocd/gocd-docker and old projects

ADD scripts/go-common-scripts.sh /usr/local/bin/
ADD scripts/go-server-start.sh /usr/local/bin/

# Download an install Go-server
ADD http://download.go.cd/gocd-deb/go-server-14.4.0-1356.deb /tmp/go-server.deb
WORKDIR /tmp
RUN dpkg -i /tmp/go-server.deb 
RUN sed -i -e 's/DAEMON=Y/DAEMON=N/' /etc/default/go-server

EXPOSE 8153 8154
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["/usr/local/bin/go-server-start.sh"]