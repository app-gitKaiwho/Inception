# Use Debian as the base image
FROM debian:buster

# Update package list and install necessary packages
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    curl \
    wget \
    unzip \
    && apt-get clean

# Create the directory for PHP-FPM socket
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# Download and extract WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz && \
    mkdir -p /var/www/html/ && \
    mv wordpress/* /var/www/html/ && \
    rmdir wordpress && \
    chown -R www-data:www-data /var/www/html/

# Download and install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Modify the PHP-FPM configuration to listen on port 9000
RUN sed -i 's/listen = .*/listen = 0.0.0.0:9000/' /etc/php/7.3/fpm/pool.d/www.conf

COPY ./tools/wpconfig.sh /

COPY ./conf/wp-config.php /

CMD [ "/wpconfig.sh" ]


#CMD ["php-fpm7.3", "-F"]

