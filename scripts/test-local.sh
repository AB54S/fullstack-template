#! /usr/bin/env bash

# Exit in case of error
set -e
set -x

cd backend
uv run bash scripts/tests-start.sh "$@"
