#!/usr/bin/env sh

set -ex

INITIAL_REF="$INPUT_INITIAL_REF"
TERMINAL_REF="$INPUT_TERMINAL_REF"
REPO="/github/workspace/$REPO_SUBDIR"

locust --format yaml -r "$REPO" $INITIAL_REF $TERMINAL_REF
