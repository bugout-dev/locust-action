#!/usr/bin/env bash

set -e

INITIAL_REF="$INPUT_INITIAL_REF"
TERMINAL_REF="$INPUT_TERMINAL_REF"
FORMAT="${INPUT_FORMAT:-json}"
REPO="/github/workspace/$REPO_SUBDIR"

if [ -z "$INITIAL_REF" ]
then
    INITIAL_REF=$(locust.github initial)
fi

if [ -z "$TERMINAL_REF" ]
then
    TERMINAL_REF=$(locust.github terminal)
fi

REPO_URL=$(locust.github repo)
COMMENTS_URL=$(python -c 'import json; import os; event = os.environ.get("GITHUB_EVENT_PATH"); raw = open(event); inp_json = json.load(raw); print(inp_json.get("pull_request").get("_links").get("comments").get("href")); raw.close();')

locust --format "$FORMAT" -r "$REPO" "$INITIAL_REF" "$TERMINAL_REF" --github "${REPO_URL}" --metadata "{\"comments_url\": \"${COMMENTS_URL}\", \"terminal_hash\": \"$TERMINAL_REF\"}" | tee /locust.summary

# Thanks to this GitHub community post:
# https://github.community/t/set-output-truncates-multiline-strings/16852/3
summary=$(cat /locust.summary)
summary="${summary//'%'/'%25'}"
summary="${summary//$'\n'/'%0A'}"
summary="${summary//$'\r'/'%0D'}"

echo "::set-output name=summary::$summary"
