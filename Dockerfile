FROM alpine:3.4

MAINTAINER guillem.canal@lagardere-active.com

ENV WEBPROC_VERSION=0.1.7
ENV WEBPROC_URL https://github.com/jpillora/webproc/releases/download/$WEBPROC_VERSION/webproc_linux_amd64.gz


RUN apk add --no-cache libcap-dev pcre-dev \
	&& apk add --no-cache --virtual .build-deps git curl gzip build-base \
	
	# Compile dnsmasq with regex support

	&& cd /tmp \
	&& git clone https://github.com/cuckoohello/dnsmasq-regex.git \
	&& cd dnsmasq-regex \
	&& make \
	&& make install \

	# Install WebProc

	&& curl -sL $WEBPROC_URL | gzip -d - > /usr/local/bin/webproc \
	&& chmod +x /usr/local/bin/webproc \

	# .Configure dnsmasq

	&& mkdir -p /etc/default/ \
	&& echo -e "ENABLED=1\nIGNORE_RESOLVCONF=yes" > /etc/default/dnsmasq \

	# Cleanup

	&& apk del .build-deps \
	&& rm -rf /tmp/*

COPY dnsmasq.conf /etc/dnsmasq.conf

CMD ["webproc","--config","/etc/dnsmasq.conf","--","dnsmasq","--no-daemon"]