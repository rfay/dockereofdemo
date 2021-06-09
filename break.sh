#!/bin/bash
set -eu -o pipefail

ddev --version
./docker-desktop-version.sh
printf "\nArchitecture: $(arch)\n"
port=80

ddev stop >/dev/null 2>&1 || true
while true; do
  ddev start >/dev/null 2>&1 && starttime=$(date)
  for item in dockereofdemo x y z a.junk b.junk c.junk d.junk; do
    url="http://${item}.ddev.site:${port}"
    curl -sSL --fail $url > /dev/null || ( printf "curl failed on $url at $(date) after ddev start finishing at ${starttime}" && ( docker inspect --format "{{json .State.Health }}" ddev-dockereofdemo-web | jq -r ) && ( docker inspect --format "{{json .State.Health }}" ddev-router ) | jq -r && exit 1 )
  done
  echo -n .
  ddev stop >/dev/null
done