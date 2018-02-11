FROM alpine:3.7

ARG PUREFTPD_VERSION=1.0.47
ARG URL=http://download.pureftpd.org/pub/pure-ftpd/releases/pure-ftpd-$PUREFTPD_VERSION.tar.gz

ENV PUBLIC_HOST localhost
ENV MIN_PASV_PORT 30000
ENV MAX_PASV_PORT 30009

RUN set -ex && \ 
	apk add --no-cache --virtual .build-deps \ 
		build-base \ 
		curl \ 
		tar && \ 
	cd /tmp && \ 
	curl -sSL $URL | tar xz --strip 1 && \ 
	
	./configure --prefix=/usr \
		--sysconfdir=/etc/pureftpd \
		--without-humor \
		--with-minimal \
		--with-throttling \
		--with-puredb \
		--with-rfc2640 \
		--with-peruserlimits \
		--with-ratios \
		--with-virtualchroot \
		--with-welcomemsg && \
	
	make install-strip && \ 
	cd .. && \ 
	rm -rf /tmp/* && \ 
	apk del .build-deps 

EXPOSE 21 $MIN_PASV_PORT-$MAX_PASV_PORT 

CMD /usr/sbin/pure-ftpd \ 
	-P $PUBLIC_HOST \
	$ADDED_FLAGS