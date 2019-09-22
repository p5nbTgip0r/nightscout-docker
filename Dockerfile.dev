FROM node:10-alpine

ARG GIT_URL=https://github.com/nightscout/cgm-remote-monitor.git
ARG GIT_BRANCH=dev
EXPOSE 1337

RUN mkdir -p /nightscout && \
  apk update && \
  apk add --no-cache --virtual build-dependencies python make g++ git && \
  apk add --no-cache tini && \
  echo "**** install w/ branch $GIT_BRANCH ****" && \
  git clone $GIT_URL --branch $GIT_BRANCH /nightscout && \
  cd /nightscout && \
  npm install --no-cache && \
  npm run postinstall && \
  npm audit fix && \
  apk del build-dependencies && \
  chown -R node:node /nightscout

ENTRYPOINT ["/sbin/tini", "--"]

WORKDIR /nightscout

USER node

CMD ["node", "server.js"]