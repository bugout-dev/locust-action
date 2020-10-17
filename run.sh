#!/usr/bin/env sh

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

echo "::set-output name=summary::$(cat /locust.summary)"
