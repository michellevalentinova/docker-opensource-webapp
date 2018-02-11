FROM nginx:1.12-alpine

ENV MEDIAWIKI_VERSION 1.30.0
ENV MEDIAWIKI_URL "https://releases.wikimedia.org/mediawiki/1.30/mediawiki-1.30.0.tar.gz"

# system configuration
ADD dow.conf /etc/nginx/conf.d/
ADD php-fpm-mediawiki.conf /etc/php7/php-fpm.d/
ADD supervisord.conf /etc/

RUN \
	# run an update and then add standard packages that will be always in the container
	apk --update --no-cache add supervisor ca-certificates \
		php7-fpm php7-json php7-mysqlnd php7-mbstring php7-xml php7-ctype php7-iconv

# move away the default nginx config so our webapp config becomes the default
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak

# move away the default PHP FPM pool so we can override settings
RUN mv /etc/php7/php-fpm.d/www.conf /etc/php7/php-fpm.d/www.conf.bak


# chain all runs to avoid creating intermediary filesystem layers as we add some packages temporarily for build only
RUN \
	# add packages that are necessary only for image build, later on removed
	apk --no-cache add curl && \

	# setup
	mkdir -p /app && \
	curl --location --show-error $MEDIAWIKI_URL -o /tmp/mediawiki.tar.gz && \
	tar -xzvf /tmp/mediawiki.tar.gz -C /app/ && \
	mv /app/mediawiki-$MEDIAWIKI_VERSION /app/public && \

	# remove packages required for build only
	apk del curl


CMD ["supervisord"]
