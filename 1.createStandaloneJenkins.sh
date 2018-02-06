#!/usr/bin/env bash

oc delete project standalone-jenkins --ignore-not-found=true --now=true
oc new-project standalone-jenkins
oc new-app --template=jenkins-ephemeral

#Give the jenkins user the right to use openshift templates
oc policy add-role-to-user registry-viewer system:serviceaccount:standalone-jenkins:jenkins -n openshift