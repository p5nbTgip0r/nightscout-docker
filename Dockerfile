FROM node:10-alpine

RUN mkdir -p /nightscout && \
  apk update && apk add git && \
  git clone https://github.com/nightscout/cgm-remote-monitor.git /nightscout
  chown -R node:node /nightscout

WORKDIR /nightscout

USER node
RUN npm install && \
  npm run postinstall && \
  npm run env

EXPOSE 1337

CMD ["node", "server.js"]
