FROM suixo/docker-nginx-php:latest
MAINTAINER Mickaël Bergem <mickael@securem.eu>

# Curl extension
RUN apt-get update && apt-get install -y curl unzip

RUN gpg --recv-keys --keyserver pgp.mit.edu 87DA4591

RUN mkdir -p /webapps/rainloop /webapps/logs/rainloop && \
	cd /tmp && \
	curl -R -L -O "http://repository.rainloop.net/v2/webmail/rainloop-community-latest.zip" && \
	curl -R -L -O "http://repository.rainloop.net/v2/webmail/rainloop-community-latest.zip.asc" && \
    gpg --verify rainloop-community-latest.zip.asc rainloop-community-latest.zip && \
	unzip rainloop-community-latest.zip -d /webapps/rainloop && \
	find /webapps/rainloop -type d -exec chmod 755 {} \; && \
	find /webapps/rainloop -type f -exec chmod 644 {} \; && \
	chown -R www-data:www-data /webapps/rainloop && \
    rm /tmp/rainloop-community-latest.zip /tmp/rainloop-community-latest.zip.asc && \
    sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php5/fpm/php-fpm.conf

# Adding files
ADD conf/nginx-rainloop.conf /etc/nginx/sites-available/default

# Add application configuration file
ADD conf/rainloop-application.ini /webapps/rainloop/data/_data_/_default_/configs/application.ini
RUN chown -R www-data:www-data /webapps/rainloop/data

# Expose services
EXPOSE 80 443
