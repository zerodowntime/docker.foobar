##
## author: Piotr Stawarski <piotr.stawarski@zerodowntime.pl>
##

ARG CENTOS_VERSION=latest

FROM zerodowntime/centos:$CENTOS_VERSION

EXPOSE 6379

RUN yum -y install epel-release && yum -y install redis

COPY confd /etc/confd

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["--logfile", ""]
