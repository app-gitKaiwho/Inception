#!/bin/bash

cd /var/www/html

rm -rf *

wp core download --allow-root

mv /wp-config.php /var/www/html/wp-config.php

sed -i -r "s/db1/$db_name/1"   wp-config.php
sed -i -r "s/user/$db_user/1"  wp-config.php
sed -i -r "s/pwd/$db_pwd/1"    wp-config.php

wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

wp plugin update --all --allow-root

mkdir /run/php

wp redis enable --allow-root

/usr/sbin/php-fpm7.3 -F