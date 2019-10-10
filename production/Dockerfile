# Production
FROM keymetrics/pm2:10-alpine
WORKDIR /app
COPY /build/package*.json /app/
RUN npm install
COPY /build/ /app/
EXPOSE 8080
CMD ["npm", "start"]
