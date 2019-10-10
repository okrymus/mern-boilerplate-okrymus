#!/bin/bash

docker network create app-network

. ./server.config

data_path="./data/certbot"
email="your@email.com" # Adding a valid address is strongly recommended
staging=0 # Set to 1 if you're testing your setup to avoid hitting request limits
rsa_key_size=4096

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

        echo "### Starting nginx ..."
        docker-compose up --force-recreate -d nginx
        echo

        echo "### Deleting dummy certificate for $domains ..."
        docker-compose run --rm --entrypoint "\
        rm -Rf /etc/letsencrypt/live/$domains && \
        rm -Rf /etc/letsencrypt/archive/$domains && \
        rm -Rf /etc/letsencrypt/renewal/$domains.conf" certbot
        echo

        echo "### Requesting Let's Encrypt certificate for $domains ..."
        #Join $domains to -d args
        domain_args=""
        for domain in "${domains[@]}"; do
        domain_args="$domain_args -d $domain"
        done

        # Select appropriate email arg
        case "$email" in
        "") email_arg="--register-unsafely-without-email" ;;
        *) email_arg="--email $email" ;;
        esac

        # Enable staging mode if needed
        if [ $staging != "0" ]; then staging_arg="--staging"; fi

        docker-compose run --rm --entrypoint "\
        certbot certonly --webroot -w /var/www/certbot \
            $staging_arg \
            $email_arg \
            $domain_args \
            --rsa-key-size $rsa_key_size \
            --agree-tos \
            --force-renewal" certbot
        echo

        echo "### Reloading nginx ..."
        docker-compose exec nginx nginx -s reload

    fi
else 

    if [ ! -e "$data_path/conf/options-ssl-nginx.conf" ] || [ ! -e "$data_path/conf/ssl-dhparams.pem" ]; then
        echo "### Downloading recommended TLS parameters ..."
        mkdir -p "$data_path/conf"
        curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/tls_configs/options-ssl-nginx.conf > "$data_path/conf/options-ssl-nginx.conf"
        curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/ssl-dhparams.pem > "$data_path/conf/ssl-dhparams.pem"
        echo
    fi

    echo "### Requesting Let's Encrypt certificate for $domains ..."
    #Join $domains to -d args
    domain_args=""
    for domain in "${domains[@]}"; do
    domain_args="$domain_args -d $domain"
    done

    # Select appropriate email arg
    case "$email" in
    "") email_arg="--register-unsafely-without-email" ;;
    *) email_arg="--email $email" ;;
    esac

    # Enable staging mode if needed
    if [ $staging != "0" ]; then staging_arg="--staging"; fi

    echo "### Starting nginx ..."
    docker-compose up --force-recreate -d nginx
    echo

    path="/etc/letsencrypt/live/$domains"
    mkdir -p "$data_path/conf/live/$domains"

    docker-compose run --rm --entrypoint "\
    certbot certonly --webroot -w /var/www/certbot \
        $staging_arg \
        $email_arg \
        $domain_args \
        --rsa-key-size $rsa_key_size \
        --agree-tos \
        --force-renewal" certbot
    echo

    echo "### Reloading nginx ..."
    docker-compose exec nginx nginx -s reload
fi

