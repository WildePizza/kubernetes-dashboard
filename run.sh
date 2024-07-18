#!/bin/bash

action=$1

execute() {
  substring="#!/bin/bash"
  sha=$(curl -sSL https://api.github.com/repos/WildePizza/kubernetes-dashboard/commits | jq -r '.[1].sha')
  url="https://raw.githubusercontent.com/WildePizza/kubernetes-dashboard/$sha/scripts/$action.sh"
  echo "Executing: $url"
  output=$(curl -fsSL $url 2>&1)
  if [[ $output =~ $substring ]]; then
    curl -fsSL $url | bash -s $sha
  else
    sleep 1
    execute
  fi
}
execute
