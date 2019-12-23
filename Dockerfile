#
# Dockerfile for a proxy
#

FROM ubuntu
MAINTAINER andrezelak <andre.zelak@telefonica.com>

RUN apt-get update \
    && apt-get install -y privoxy gosu wget iptables iproute2 vim less tree

RUN sed -i -e '/^listen-address/s/127.0.0.1/0.0.0.0/' \
           -e '/^listen-address.*\[::1\]/d' \
           -e '/^accept-intercepted-requests/s/0/1/' \
           -e '/^enforce-blocks/s/0/1/' \
           -e '/^#debug/s/#//' /etc/privoxy/config

VOLUME /etc/privoxy

EXPOSE 8118

CMD gosu privoxy privoxy --no-daemon /etc/privoxy/config
