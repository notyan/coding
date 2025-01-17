#!/bin/bash

source .env

DIR="lemp"
NGINX="${DIR}/nginx"
APP="${DIR}/app"

if [[ $1 == "--cleanup" ]]; then
    if [[ -d "$DIR" ]]; then
        (cd "$DIR" && docker-compose down -v;)
        rm -rf "$DIR"
    fi
    echo "Working dir Cleaned"
    exit 1;
fi

#Check and Create Directory
[[ ! -d "$NGINX" ]] && mkdir -p "$NGINX"
[[ ! -d "$APP" ]] && mkdir -p "$APP"

#Generate app file
cat > "${APP}/index.php" << EOF
<?php
echo "Hello World!" ;
EOF

#Generate nginx.conf file
cat > "${NGINX}/default.conf" << EOF
server {
    listen 80;
    server_name localhost;

    root /var/www/html;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \\.php$ {
        include fastcgi_params;
        fastcgi_pass phpFpm:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
}
EOF


#Generate Docker Compose File
cat > ${DIR}/docker-compose.yml << EOF
services: 
  phpFpm:
    image: php:8.2-fpm
    container_name: lemp-php
    networks:
      - lemp_net
    volumes:
      - ./app:/var/www/html

  nginx:
    image: nginx:latest
    container_name: lemp-nginx
    ports:
        - '8000:80'
    volumes:
        - ./app:/var/www/html
        - ./nginx:/etc/nginx/conf.d
    depends_on:
      - phpFpm
    networks:
      - lemp_net

  mariadb:
    image: mariadb:lts
    container_name: lemp-mariadb
    ports:
      - "3306:3306"
    restart: 'on-failure'
    environment:
      MARIADB_ROOT_PASSWORD: ${MARIADB_ROOT_PASSWORD:?err}
      MARIADB_DATABASE: ${MARIADB_DATABASE:?err}
      MARIADB_USER: ${MARIADB_USER:?err}
      MARIADB_PASSWORD: ${MARIADB_PASSWORD:?err}
    volumes:
      - db_volume:/var/lib/mysql
    networks:
      - lemp_net
  
networks:
  lemp_net:
    driver: bridge

volumes:
  db_volume:

EOF

if (cd $DIR; docker compose up -d;) then
    echo "LEMP Is running on"
    echo "mysql     : http://localhost:3306"
    echo "app       : http://localhost:8000"
else 
    echo "error, check docker logs"
    exit 1
fi
