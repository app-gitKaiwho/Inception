#!/bin/bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $SSL_KEY -out $CERTS_ -subj "/C=GG/L=TheDepth/O=ONU/OU=Jesus/CN=lvon-war"

echo "
server {
    listen 443 ssl; #http2 format was deprecated 
    listen [::]:443 ssl;

    #server_name www.$DOMAIN_NAME $DOMAIN_NAME;

    ssl_certificate $CERTS_;
    ssl_certificate_key $SSL_KEY;" > /etc/nginx/sites-available/default

echo '
    index index.php;
    root /var/www/html;

    location ~ \.php$ { 
            fastcgi_split_path_info ^(.+\.php)(.*)$;
            try_files $uri = 404;
            fastcgi_pass wordpress:9000;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }

    location ~/\.ht {
        deny all;
    }
} ' >>  /etc/nginx/sites-available/default

nginx -g "daemon off;"