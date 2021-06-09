#!/bin/bash
set -eu -o pipefail

./docker-desktop-version.sh
printf "\nArchitecture: $(arch)\n"

docker stop nginx >/dev/null 2>&1 || true
while true; do
  echo -n .
  ddev start >/dev/null 2>&1 && starttime=$(date)
  curl -sSL --fail http://dockereofdemo.ddev.site:8080 >/dev/null || ( printf "curl failed at $(date) after ddev start finishing at ${starttime}" && docker inspect --format "{{json .State.Health }}" ddev-dockereofdemo-web && exit 1 )
  ddev stop >/dev/null
done