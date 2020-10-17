#!/usr/bin/env sh

set -e

INITIAL_REF="$INPUT_INITIAL_REF"
TERMINAL_REF="$INPUT_TERMINAL_REF"
REPO="/github/workspace/$REPO_SUBDIR"

echo "GITHUB_EVENT_NAME: $GITHUB_EVENT_NAME"

locust --format yaml -r "$REPO" $INITIAL_REF $TERMINAL_REF
