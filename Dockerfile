FROM alpine:3.3

RUN apk add --no-cache curl bash jq gettext-dev

COPY check /opt/resource/check
COPY in    /opt/resource/in
COPY out   /opt/resource/out
COPY bot_message.sh    /opt/resource/bot_message.sh
COPY bot_search.sh     /opt/resource/bot_search.sh

RUN chmod +x /opt/resource/out /opt/resource/in /opt/resource/check

ADD test/ /opt/resource-tests/
RUN /opt/resource-tests/all.sh \
 && rm -rf /tmp/*
