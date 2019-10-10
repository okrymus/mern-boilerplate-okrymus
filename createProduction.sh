docker run -v "$PWD":/app -w /app --rm node:alpine sh -c 'cd mern-boilerplate  && npm run build'
docker rmi node:alpine  -f

# mkdir -p linux-x64-72
# curl -L https://github.com/sass/node-sass/releases/download/v4.12.0/linux-x64-72_binding.node -o linux-x64-72/binding.node

# if [ ! -d ./okrymus-boilerplate/client/node_modules/node-sass/vendor/linux-x64-72/ ]; then
#     mv -v linux-x64-72 ./okrymus-boilerplate/client/node_modules/node-sass/vendor/
# fi
