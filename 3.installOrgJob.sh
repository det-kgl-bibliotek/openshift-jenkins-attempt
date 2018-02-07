#!/usr/bin/env bash

JENKINS='https://jenkins-standalone-jenkins.apps-test.kb.dk'

ocToken=$(oc whoami --show-token)

curl \
    --silent \
    --header "Authorization: Bearer $ocToken" \
    -X POST \
    --insecure \
    "$JENKINS/createItem?name=det+kgl+bibliotek" \
    --data-binary @orgJob.xml \
    -H "Content-Type:text/xml" \
    > job.html


curl \
    --silent \
    --header "Authorization: Bearer $ocToken" \
    -X POST \
    --insecure \
    --header "Authorization: Bearer $ocToken" \
    "$JENKINS/job/det%20kgl%20bibliotek/build" \
    > build.html

