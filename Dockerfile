FROM alpine:latest

LABEL maintainer="Kenson Man <kenson@kenson.idv.hk>"
LABEL version="prestashop-v1.7.6.1"

ENV WDIR=/usr/share/nginx/html

# Copy the file into the container
COPY bin/* ${WDIR}/
COPY scripts/* /scripts/

RUN echo ">>   Installing dependancies..." \
 && mkdir -p /var/log/supervisor \
 && apk update \
 && apk upgrade \
 && apk add --update --no-cache bash build-base linux-headers vim nginx supervisor \
 php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-dom php7-fileinfo php7-intl php7-json php7-zip php7-simplexml php7-tokenizer php7-session \
 php7-pdo php7-pdo_mysql php7-iconv php7-posix \
 && echo ">>   Configurating ..." \
 && adduser -S theuser \
 && adduser theuser www-data \
 && rm -rf /etc/php7/php-fpm.d/www.conf \
 && ln -s /scripts/www.conf /etc/php7/php-fpm.d/www.conf \
 && chown -R theuser:www-data ${WDIR} \
 && chmod +x /scripts/entrypoint \
 && cd ${WDIR} \
 && chown -R theuser:www-data ${WDIR} \
 && ln -s /scripts/entrypoint /usr/bin/entrypoint \
 && echo ">>   Finishing..."

EXPOSE 80

ENTRYPOINT ["/scripts/entrypoint"]
CMD ["run"]
WORKDIR /tmp
