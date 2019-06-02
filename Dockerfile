FROM node:10-alpine

ARG GIT_BRANCH=master
EXPOSE 1337

RUN mkdir -p /nightscout && \
  apk update && apk add git && \
  echo "**** install w/ branch $GIT_BRANCH ****" && \
  git clone https://github.com/nightscout/cgm-remote-monitor.git --branch $GIT_BRANCH /nightscout && \
  chown -R node:node /nightscout

WORKDIR /nightscout

USER node
RUN npm install && \
  npm run postinstall && \
  npm audit fix

CMD ["node", "server.js"]