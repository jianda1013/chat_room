FROM node:16-alpine

WORKDIR /usr/src/app

COPY ./package* ./

RUN npm install

RUN npm install -g nodemon

# CMD ["nodemon", "index.js"]
CMD ["sleep", "infinity"]