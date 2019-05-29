FROM nediiii/alpine as builder

RUN apk add --no-cache py-pip && \
    pip install gfwlist2privoxy && \
    gfwlist2privoxy -i https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt -t socks5 -p 127.0.0.1:1080 -f /root/gfwlist.action && \
    chmod 660 /root/gfwlist.action

# ---------------------------------------------------------------------------------------------------------------------

FROM nediiii/shadowsocks-libev

LABEL maintainer="nediiii <varnediiii@gmail.com>"

RUN apk add --no-cache privoxy && \
    echo "actionsfile gfwlist.action" >> /etc/privoxy/config && \
    sed -i 's/enable-edit-actions 0/enable-edit-actions 1/g' /etc/privoxy/config && \
    sed -i 's/listen-address  127.0.0.1:8118/listen-address  0.0.0.0:8118/g' /etc/privoxy/config

COPY --from=builder --chown=privoxy:privoxy /root/gfwlist.action /etc/privoxy/gfwlist.action

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

# docker build . --no-cache -t nediiii/shadowsocks-libev-privoxy