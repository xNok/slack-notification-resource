#!/bin/bash
echo -e "\n\e[34msearching for a Thread\e[0m\n"

# Interpolate query in case there is more to it
QUERY=$(eval "echo $QUERY")

echo -e "$VERSION"
echo -e "$CHANNEL"
echo -e "$QUERY"

if [ "$sort" == "" ]; then sort="timestamp" ;fi
if [ "$sort_dir" == "" ]; then sort_dir="asc" ;fi
if [ "$highlight" == "" ]; then highlight="1" ;fi
if [ "$count" == "" ]; then count="20" ;fi
if [ "$page" == "" ]; then page="1" ;fi

curl -GX GET \
  "https://slack.com/api/search.messages" \
  --data-urlencode "token=$TOKEN" \
  --data-urlencode "query=$QUERY" \
  --data-urlencode "sort=$sort" \
  --data-urlencode "sort_dir=$sort_dir" \
  --data-urlencode "highlight=$highlight" \
  --data-urlencode "count=$count" \
  --data-urlencode "page=$page" \
  -H "Authorization: Bearer $TOKEN" \
  -H 'cache-control: no-cache' > slack-output/search.json

jq . slack-output/search.json

NBR_MSG=$(cat slack-output/search.json | jq '.messages.total')

if [ $NBR_MSG -ge 1 ]; then
    TS=$(cat slack-output/search.json | jq -r '.messages.matches[0].ts')
fi