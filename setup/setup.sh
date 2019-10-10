#!/bin/bash

. ./setup.config

echo domains="($domains www.$domains)" > ../nginxServer/server.config

cp -R ./temp/env .

cd env
LC_ALL=C find ./ -type f -exec sed -i '' "s+example.org+$domains+g" {} \;
LC_ALL=C find ./ -type f -exec sed -i '' "s+MONGOLAB_DB_URL+$MONGOLAB_DB_URL+g" {} \;
LC_ALL=C find ./ -type f -exec sed -i '' "s+MONGOLAB_DB_USERNAME+$MONGOLAB_DB_USERNAME+g" {} \;
LC_ALL=C find ./ -type f -exec sed -i '' "s+MONGOLAB_DB_PASSWORD+$MONGOLAB_DB_PASSWORD+g" {} \;
LC_ALL=C find ./ -type f -exec sed -i '' "s+GMAIL_ADDRESS+$GMAIL_ADDRESS+g" {} \;
LC_ALL=C find ./ -type f -exec sed -i '' "s+GMAIL_PASSWORD+$GMAIL_PASSWORD+g" {} \;

cp -R .env ../../mern-boilerplate/server
cp -R .env.development ../../mern-boilerplate/client
cp -R .env.production ../../mern-boilerplate/client
