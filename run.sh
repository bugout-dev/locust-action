#!/usr/bin/env sh

set -e

INITIAL_REF="$INPUT_INITIAL_REF"
TERMINAL_REF="$INPUT_TERMINAL_REF"
REPO="/github/workspace/$REPO_SUBDIR"

echo "GITHUB_EVENT_NAME: $GITHUB_EVENT_NAME"
echo "GITHUB_EVENT:"
cat "$GITHUB_EVENT_PATH"

if [ -z "$INITIAL_REF" ]
then
    if [ "$GITHUB_EVENT_NAME" = "push" ]
    then
        INITIAL_REF="HEAD~1"
    fi
fi


locust --format yaml -r "$REPO" $INITIAL_REF $TERMINAL_REF
