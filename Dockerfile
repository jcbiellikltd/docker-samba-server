FROM alpine:latest

ENV UID 1000
ENV USERNAME samba
ENV GID 1000
ENV GROUP samba
ENV PASSWORD password

RUN set -xe \
	&& apk add --update --no-progress samba-common-tools samba-server openssl \
	&& rm -rf /var/cache/apk/*

ENV S6_VERSION 1.17.2.0
RUN set -xe \
	&& cd /tmp \
	&& wget https://github.com/just-containers/s6-overlay/releases/download/v$S6_VERSION/s6-overlay-amd64.tar.gz \
	&& wget https://github.com/just-containers/s6-overlay/releases/download/v$S6_VERSION/s6-overlay-amd64.tar.gz.sig \
	&& apk add --update --no-progress --virtual gpg gnupg \
	&& gpg --keyserver pgp.mit.edu --recv-key 0x337EE704693C17EF \
	&& gpg --verify /tmp/s6-overlay-amd64.tar.gz.sig /tmp/s6-overlay-amd64.tar.gz \
	&& tar xzf s6-overlay-amd64.tar.gz -C / \
	&& apk del gpg \
	&& rm -rf /tmp/s6-overlay-amd64.tar.gz /tmp/s6-overlay-amd64.tar.gz.sig /root/.gnupg /var/cache/apk/*

COPY samba.s6 /etc/services.d/samba/run

RUN mkdir /config
VOLUME ["/config"]

EXPOSE 137/udp 138/udp 139/tcp 445/tcp

CMD ["/init"]
