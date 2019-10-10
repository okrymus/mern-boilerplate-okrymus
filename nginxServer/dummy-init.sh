#!/bin/bash
. ./server.config
docker network create app-network
data_path="./data/certbot"

sed "s/example.org/$domains/g" default.conf > ./data/nginx/default.conf

if [ -d "$data_path" ]; then
    read -p "Existing data found for $domains. Continue and replace existing certificate? (y/N) " decision
    if [ "$decision" == "Y" ] || [ "$decision" == "y" ]; then
        if [ ! -e "$data_path/conf/options-ssl-nginx.conf" ] || [ ! -e "$data_path/conf/ssl-dhparams.pem" ]; then
            echo "### Downloading recommended TLS parameters ..."
            mkdir -p "$data_path/conf"
            curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/tls_configs/options-ssl-nginx.conf > "$data_path/conf/options-ssl-nginx.conf"
            curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/ssl-dhparams.pem > "$data_path/conf/ssl-dhparams.pem"
            echo
        fi
        echo "### Creating dummy certificate for $domains ..."
        path="/etc/letsencrypt/live/$domains"
        mkdir -p "$data_path/conf/live/$domains"
        docker-compose run --rm --entrypoint "\
        openssl req -x509 -nodes -sha256 -newkey rsa:2048 -days 1\
        -keyout '$path/privkey.pem' \
        -out '$path/fullchain.pem' \
        -subj '/CN=localhost'" certbot
        echo
    fi
else 

    if [ ! -e "$data_path/conf/options-ssl-nginx.conf" ] || [ ! -e "$data_path/conf/ssl-dhparams.pem" ]; then
        echo "### Downloading recommended TLS parameters ..."
        mkdir -p "$data_path/conf"
        curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/tls_configs/options-ssl-nginx.conf > "$data_path/conf/options-ssl-nginx.conf"
        curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/ssl-dhparams.pem > "$data_path/conf/ssl-dhparams.pem"
        echo
    fi
    echo "### Creating dummy certificate for $domains ..."
    path="/etc/letsencrypt/live/$domains"
    mkdir -p "$data_path/conf/live/$domains"
    docker-compose run --rm --entrypoint "\
    openssl req -x509 -nodes -sha256 -newkey rsa:2048 -days 1\
    -keyout '$path/privkey.pem' \
    -out '$path/fullchain.pem' \
    -subj '/CN=localhost'" certbot
    echo
fi

