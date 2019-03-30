FROM alpine:latest

ENV USERNAME samba
ENV PASSWORD password
ENV UID 1000
ENV GID 1000

RUN apk add --no-cache samba-server samba-common-tools openssl

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

COPY s6/config.init /etc/cont-init.d/00-config
COPY s6/smbd.run /etc/services.d/smbd/run
COPY s6/nmbd.run /etc/services.d/nmbd/run

EXPOSE 137/udp 138/udp 139/tcp 445/tcp

CMD ["/init"]
