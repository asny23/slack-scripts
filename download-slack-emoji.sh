#!/bin/bash

# get token from https://api.slack.com/custom-integrations/legacy-tokens
SLACK_TOKEN=''

OUT_DIR='slack-images'
if [ ! -d $OUT_DIR  ] ; then
  mkdir $OUT_DIR
fi

curl -q -s "https://slack.com/api/emoji.list?token=$SLACK_TOKEN" | jq -Mr '.emoji | to_entries | .[] | select(.value | startswith("http")) | "\(.key) \(.value)"' | sort | while read name url; do
  fn="$name.${url##*.}"
  if [ -f $OUT_DIR/$fn  ] ; then
    echo "$fn exists"
  else
    echo "$fn downloading"
    curl -q -s -o "$OUT_DIR/$fn" "$url"
  fi
done
