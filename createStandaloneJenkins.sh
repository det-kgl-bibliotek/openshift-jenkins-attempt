#!/usr/bin/env bash

oc delete project standalone-jenkins
oc new-project standalone-jenkins
oc new-app --template=jenkins-ephemeral



curl -s -XPOST 'https://jenkins-standalone-jenkins.apps-test.kb.dk/createItem?name=det+kgl+bibliotek' --data-binary @config.xml -H "Content-Type:text/xml" --user user.name:YourAPIToken
