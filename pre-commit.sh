#!/usr/bin/env bash -eu

docker build -t frontend-test .
docker run -it --rm -v $(pwd):/app frontend-test ./test.sh
