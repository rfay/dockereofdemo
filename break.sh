#!/bin/bash
set -eu -o pipefail

./docker-desktop-version.sh
printf "\nArchitecture: $(arch)"
printf "\nRunning nginx container and curling it\n"
docker stop nginx >/dev/null 2>&1 || true
while true; do
  echo -n .
  docker run --name nginx --rm -p 8080:80 -v $PWD:/usr/share/nginx/html:ro -d nginx >/dev/null
  curl -sSL --fail http://localhost:8080 >/dev/null
  docker stop nginx >/dev/null
done