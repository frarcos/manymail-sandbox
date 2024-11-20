#!/bin/sh

npm install -g npm --unsafe-perm=true
npm update --save --unsafe-perm=true
npm install

npm run docker
