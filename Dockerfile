FROM node:10-alpine

ARG GIT_BRANCH=master
EXPOSE 1337

RUN mkdir -p /nightscout && \
  apk update && apk add --no-cache --virtual build-dependencies python make g++ git && \
  echo "**** install w/ branch $GIT_BRANCH ****" && \
  git clone https://github.com/nightscout/cgm-remote-monitor.git --branch $GIT_BRANCH /nightscout && \
  chown -R node:node /nightscout

WORKDIR /nightscout

RUN npm install --no-cache && \
  npm run postinstall && \
  npm audit fix && \
  apk del build-dependencies

USER node

CMD ["node", "server.js"]