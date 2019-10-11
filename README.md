# MERN Boilerplate

[![GitHub license](https://img.shields.io/github/license/tamasszoke/mern-boilerplate.svg)](https://github.com/tamasszoke/mern-boilerplate/blob/master/LICENSE)

Boilerplate for MERN stack development, ready for production.

**Highlights**

+ [Nginx](https://www.nginx.com) server 
+ [Certbot](https://certbot.eff.org) open source software tool for automatically using Let’s Encrypt certificates
+ [Docker](https://www.docker.com/) containers
+ Using [HTTP/2](https://http2.github.io/)
+ [Redis](https://www.npmjs.com/package/connect-redis) for sessions
+ Folder by Feature structure
+ Minimal [Material UI](https://material-ui.com/) design
+ Built-in React routing, [Redux](https://redux.js.org/)
+ Built-in local authentication with [Passport](http://www.passportjs.org/)
+ Built-in [Socket.IO](https://socket.io/) connection
+ [EJS](https://ejs.co/) for rendering
+ Handling database with [Mongoose](https://mongoosejs.com/)
+ Email sending by [NodeMailer](https://nodemailer.com/about/)
+ [Winston](https://github.com/winstonjs/winston) for logging
+ Testing with [Mocha](https://mochajs.org/) and [Chai](https://www.chaijs.com/)
+ Clean code with [ESLint](https://eslint.org/), [JavaScript Standard Style](https://standardjs.com/)
+ [Webpack](https://webpack.js.org/) built production server
+ Using [PM2](http://pm2.keymetrics.io/) (cluster mode) for production

## Support

[MEAN-boilerplate](https://github.com/tamasszoke/mern-boilerplate) from Tamas Szoke. You can support him at the [link](https://github.com/tamasszoke/mern-boilerplate)

## Installation

1. Create database
2. Register Domain(optional)
1. Set env variables
2. Install dependencies and 
3. Add dummy SSL certificate
4. Create database

**Create database**

Create MongoDB with a collection called `users`.
You can create account and use cloud database from [mongoDB](https://www.mongodb.com/).

**MERN Stack on AWS EC2 (optional)**

1. Create a new instance of an AWS EC2 Ubuntu server
***Make sure you do these steps of launching an instance***
- Select type of server with the latest Ubuntu version
- Add a security group for http and https
- Create and download a new key pair (you  will need the key to access the server)  and place it inside <code>./setup/SSH/</code> folder
- Launch the instance

2. Open your terminal, navigate to your key pair file location  <code>chmod 400 ./YOUR_KEY_PAIR_NAME.pem </code>

3. Copy your instance's IPv4 Public IP, it should be under your instance description. You’ll need it for domain DNS setup.

**Register Domain(optional)**

I've used [goDaddy](https://www.godaddy.com) to have my own domain.
- You’ll have to point the DNS to your EC2 public IP.
- Paste your EC2 public IP in your domain's DNS Management

**Setup env variables**

Edit setup.config file inside <code>setup/</code>  folder

Example:

    domains=(example.org www.example.org)
    MONGOLAB_DB_URL="example-cx1pi.mongodb.net/exampleDB?retryWrites=true\&w=majority"
    MONGOLAB_DB_USERNAME=databaseUser
    MONGOLAB_DB_PASSWORD=databaseUserPWD
    GMAIL_ADDRESS=youremail@gmail.com
    GMAIL_PASSWORD=emailpassword
    AMAZON_PUBLIC_DNS=ec2-00-000-000-000.compute-1.amazonaws.com
    AMAZON_USER=ubuntu
    SSH_FILENAME=YOUR_KEY_PAIR_NAME.pem

Save file and then Open terminal Enter <code>./setup.sh</code>

**Install dependencies and Create production**

Run command <code>./createProduction.sh</code> at the project's root folder. It will automatically install dependencies and create production. Your production folder is located at <code>production/build</code>

Note: every time you need to create production, you will need to run the command.

**Add SSL Dummy**

Run command <code>./dummy-init.sh</code> inside <code>/nginxServer</code> folder

## Usage

### Development
Note: use the following commands at the development folder.

1. Start: <code>./init.sh</code>
2. Go to <code>https://localhost:3001</code> in browser for server
3. Go to <code>http://localhost:3002</code> in browser for client

### Production
** Testing on localhost
Firstly, Map localhost to your domain name
1. On the terminal, open your local machine’s hosts config file:
nano <code> /etc/hosts</code>
Simply add a new line <code>127.0.0.1  yourdomainname.com</code>

Note: use the following commands at the production folder.
2. Start: <code>./init.sh</code>

Note: use the following commands at the nginxServer folder.
3. Start: <code>docker-compose up</code>

4. Go to <code>https://yourdomainname.com</code>

###  Deployment
1. Add your email address in init.sh file located inside nginxServer folder
Note: Set staging to 1 if you're testing your setup to avoid hitting request limits
2. Copy and upload nginxServer and productive to your server EC2
Example
    <code>scp -i path_to_SSH_file -r production $AMAZON_USER@$AMAZON_PUBLIC_DNS:/home/ubuntu/
    </code>
    <code>scp -i path_to_SSH_file -r nginxServer $AMAZON_USER@$AMAZON_PUBLIC_DNS:/home/ubuntu/
    </code>

3. Connect to your server
Example
    <code>ssh -i path_to_SSH_file $AMAZON_USER@$AMAZON_PUBLIC_DNS
</code>

4. On the server terminal,
    - Run command <code>./init.sh</code> inside the <code>production/</code> folder
    - Run command <code>./init.sh</code> inside the <code>nginxServer/</code> folder
    - Run command <code>docker-compose up</code> inside the <code>nginxServer/</code> folder
    - Go to <code>https://yourdomainname.com</code>
Note: you will need multiple terminal windows to run these commands
## Docker commands

Stop all containers: docker stop $(docker ps -a -q)
Remove all containers: echo y  | docker system prune -a

## License

**The MIT License (MIT)**<br/>
Copyright (c) 2019 Tamas Szoke

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[https://opensource.org/licenses/MIT](https://opensource.org/licenses/MIT)
