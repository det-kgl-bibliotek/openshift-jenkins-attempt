#!/usr/bin/env bash

oc delete project standalone-jenkins --ignore-not-found=true --now=true
oc new-project standalone-jenkins
oc new-app --template=jenkins-ephemeral
