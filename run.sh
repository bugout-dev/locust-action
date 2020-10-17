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

locust --format "$FORMAT" -r "$REPO" "$INITIAL_REF" "$TERMINAL_REF" | tee /locust.summary

# Thanks to this GitHub community post:
# https://github.community/t/set-output-truncates-multiline-strings/16852/3
summary=$(cat /locust.summary)
summary="${summary//'%'/'%25'}"
summary="${summary//$'\n'/'%0A'}"
summary="${summary//$'\r'/'%0D'}"

echo "::set-output name=summary::$summary"
