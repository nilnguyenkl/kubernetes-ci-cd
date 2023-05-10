FROM node:7

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json gulpfile.js yarn.lock /usr/src/app/

RUN yarn --pure-lockfile
# RUN npm install fetch-retry --save
RUN npm i fetch-retry@1.1.0

# Bundle app source
COPY . /usr/src/app

EXPOSE 3002

CMD [ "npm", "run", "start" ]