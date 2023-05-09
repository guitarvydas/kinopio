#!/usr/bin/env bash

curl -s -H "Authorization: $2" https://api.kinopio.club/space/$1 > kinopio.tmp

jq . <kinopio.tmp >kinopio.json
echo '```' >kinopio.json.md
cat kinopio.json >>kinopio.json.md
echo '```' >>kinopio.json.md

echo ---
echo -n "title: "
cat kinopio.json | jq .name
echo -n "date: "
cat kinopio.json | jq .updatedAt
echo "layout: layouts/post.njk"
echo ---

cat kinopio.json | jq -r '.cards | sort_by(.y) | sort_by(.x) | .[] | .name + "\n"'

# rm kinopio.tmp
