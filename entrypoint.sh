#!/bin/bash -l

set -u


URI=https://api.github.com
API_VERSION=v3
API_HEADER="Accept: application/vnd.github.${API_VERSION}+json; application/vnd.github.antiope-preview+json"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

result=$(gitleaks -v --exclude-forks --redact --threads=1 --repo-path=$GITHUB_WORKSPACE)

if [ $? -eq 1 ]; then
    if [ "$GITHUB_EVENT_NAME" = "pull_request" ]; then
        NUMBER=$(jq --raw-output .number "$GITHUB_EVENT_PATH")
        data="$( jq --null-input --compact-output --arg str "$result" '{"body": $str}' )"
        curl -sSL -H "${AUTH_HEADER}" -H "${API_HEADER}" -d "$data" -H "Content-Type: application/json" -X POST "${URI}/repos/${GITHUB_REPOSITORY}/issues/${NUMBER}/comments"
        exit 1
    else        
        data="$( jq --null-input --compact-output --arg str "$result" '{"title": "[gitCret] Sensitive Credentials Detected ['${GITHUB_SHA}']", "body": $str,"labels":["security","gitcret"]}' )"
        curl -sSL -H "${AUTH_HEADER}" -H "${API_HEADER}" -d "$data" -H "Content-Type: application/json" -X POST "${URI}/repos/${GITHUB_REPOSITORY}/issues"
        echo $result
        exit 1
    fi
else
    echo $result
fi
