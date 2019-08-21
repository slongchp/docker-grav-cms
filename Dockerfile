FROM alpine
LABEL Maintainer="SB Longchamp <_@sblongchamp.com>" \
      Description="Moddable Container for Grav CMS based on alpine linux"

RUN apk --no-cache add git nginx openssh-client php7 php7-fpm php7-ctype \
      php7-curl php7-dom php7-gd php7-json php7-ldap php7-mbstring php7-openssl \
      php7-redis php7-session php7-simplexml php7-xml php7-zip php7-apcu \
      php7-opcache php7-yaml supervisor && \
    mkdir -p /app && chown nginx:nginx /app

WORKDIR /app
ENV GRAV_VERSION='1.6.15'
RUN wget https://github.com/getgrav/grav/releases/download/${GRAV_VERSION}/grav-admin-v${GRAV_VERSION}.zip && \
    unzip grav-admin-v${GRAV_VERSION}.zip && \
    mv grav-admin/* grav-admin/.htaccess .

    # RUN Cleanup
RUN rm -rf grav-admin-v${GRAV_VERSION}.zip grav-admin && \
    cd user && \
    git init

COPY secret-sauce/nginx.conf       /etc/nginx/nginx.conf
COPY secret-sauce/fpm-pool.conf    /etc/php7/php-fpm.d/www.conf
COPY secret-sauce/php.ini          /etc/php7/conf.d/99-custom.ini
COPY secret-sauce/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chown -R nginx:nginx /app

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
