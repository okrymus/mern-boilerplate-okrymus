. ./setup/setup.config

scp -i ./setup/SSH/$SSH_FILENAME -r production $AMAZON_USER@$AMAZON_PUBLIC_DNS:/home/ubuntu/
# scp -i ./setup/SSH/$SSH_FILENAME -r nginxServer $AMAZON_USER@$AMAZON_PUBLIC_DNS:/home/ubuntu/

