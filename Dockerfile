FROM node:10-alpine

RUN mkdir -p /opt/nightscout && \
  git clone https://github.com/nightscout/cgm-remote-monitor.git /opt/nightscout

WORKDIR /opt/nightscout

RUN npm install && \
  npm run postinstall && \
  npm run env

EXPOSE 1337

CMD ["node", "server.js"]
