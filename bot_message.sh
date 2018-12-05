#!/bin/bash
echo -e "\n\e[34mSending a message\e[0m\n"

TEXT=$(eval "echo $TEXT")

if [[ ! -f $ATTACHMENTS ]]; then
    ATTACHMENTS="./git-concourse/04_tasks/slack-notification/default-attachements.json"
fi

ATTACHMENTS=$(cat $ATTACHMENTS | envsubst)

cat > ./message.json <<EOF
{
    "token": "${TOKEN}",
    "channel": "${CHANNEL}",
    "text": "${TEXT}",
    "attachments": ${ATTACHMENTS},
    "thread_ts": "${TS}"
}
EOF

curl -X POST \
  https://slack.com/api/chat.postMessage \
  -H "Authorization: Bearer $TOKEN" \
  -H 'Content-Type: application/json; charset=utf-8' \
  -H 'cache-control: no-cache' \
  -d @message.json