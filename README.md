# shadowsocks-libev with privoxy

## What is it

This is a docker image base on shadowsocks-libev and integrated with privoxy which use gfwlist to determine whether proxy or not.
It work well for me, and only recommend use in mainland china.

## How to use

1. docker run this images with correct map ports
2. set up your system proxy settings
3. enjoy it

Maybe you want to add some `exception URL` to the action list for some special purpose, just visit [http://config.privoxy.org](http://config.privoxy.org) when the container is running. You can edit the config on web browser now.

### With a `docker-compose.yml`

```yaml
version: "3"
services:
  sslocal:
    image: nediiii/shadowsocks-libev-privoxy
    restart: always
    environment:
      SERVER_ADDR: 198.199.101.152
      SERVER_PORT: 8838
      PASSWORD: YOUR_PASSWORD
      METHOD: aes-256-cfb
    ports:
      - 8118:8118
      - 1080:1080
    restart: always
```

```bash
docker-compose up -d
```

### Without a `docker-compose.yml`

```bash
docker run -d \
--name ss-pri \
--restart=always \
-e SERVER_ADDR=198.199.101.152 \
-e SERVER_PORT=8838 \
-e PASSWORD=YOUR_PASSWORD \
-e METHOD=aes-256-cfb \
-p 8118:8118 \
-p 1080:1080 \
nediiii/shadowsocks-libev-privoxy
```

## images info

### reference

- [shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev)
- [privoxy](https://www.privoxy.org)
- [gfwlist](https://github.com/gfwlist/gfwlist)
- [gfwlist2privoxy](https://github.com/snachx/gfwlist2privoxy)

### environment

```script
ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV PASSWORD=
ENV METHOD      aes-256-gcm
ENV TIMEOUT     300
```

### ports

- 8118 for privoxy  (http  proxy)
- 1080 for ss-local (sock5 proxy)
