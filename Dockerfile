FROM alpine

MAINTAINER Acris Liu "qq5567423@gmail.com"

ENV FRP_VERSION 0.13.0

RUN set -ex \
    && apk add --no-cache --virtual .build-deps openssl \
    && cd /tmp \
    && wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amdhf.tar.gz \
    && tar zxvf frp_${FRP_VERSION}_linux_amdhf.tar.gz \
    && rm frp_${FRP_VERSION}_linux_amdhf.tar.gz \
    && cd frp_${FRP_VERSION}_linux_amdhf \
    && cp frps /usr/local/bin \
    && cp frpc /usr/local/bin \
    && mkdir /etc/frp \
    && cp frps.ini /etc/frp \
    && cp frpc.ini /etc/frp \
    && cd .. \
    && rm -rf frp_${FRP_VERSION}_linux_amdhf \
    && apk del .build-deps

VOLUME /etc/frp

CMD ["frps", "-c", "/etc/frp/frps.ini"]
