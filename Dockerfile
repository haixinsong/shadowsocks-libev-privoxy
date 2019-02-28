FROM shadowsocks/shadowsocks-libev

LABEL maintainer="nediiii <varnediiii@gmail.com>"

USER root

# uncomment next line to speed up build
# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories 

RUN apk add --no-cache privoxy

ADD ./privoxy/ /etc/privoxy/

EXPOSE 1080 8118

CMD /usr/sbin/privoxy /etc/privoxy/config \
    && \
    ss-local \
    -s $SERVER_ADDR \
    -p $SERVER_PORT \
    -k $PASSWORD \
    -m $METHOD \
    -b 0.0.0.0 \
    -l 1080 \
    -t $TIMEOUT \
    --fast-open \
    -u
