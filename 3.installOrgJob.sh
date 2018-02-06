#!/usr/bin/env bash


ocToken=$(oc whoami --show-token)

curl -s \
    --header "Authorization: Bearer $ocToken" \
    -X POST \
    --insecure \
    'https://jenkins-standalone-jenkins.apps-test.kb.dk/createItem?name=det+kgl+bibliotek' \
    --data-binary @config.xml \
    -H "Content-Type:text/xml"
