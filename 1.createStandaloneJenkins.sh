#!/usr/bin/env bash

set -x
oc delete project standalone-jenkins --ignore-not-found=true --now=true
set -e
until (oc delete project standalone-jenkins --ignore-not-found=true --now=true); do
    sleep 5
done

oc new-project standalone-jenkins
oc new-app --template=jenkins-ephemeral


# https://docs.openshift.com/enterprise/3.0/architecture/additional_concepts/authorization.html#roles
#Give the jenkins user the right to use openshift templates
oc policy add-role-to-user registry-viewer system:serviceaccount:standalone-jenkins:jenkins -n openshift

#Allow the jenkins user to create new projects
# see oc policy who-can create projectrequests --all-namespaces
# https://github.com/openshift/origin/issues/17067
oc adm policy add-cluster-role-to-user self-provisioner system:serviceaccount:standalone-jenkins:jenkins

#Allow the jenkins user to view stuff about other projects
#Solve issues with the jenkins user being able to wait for project deletion
#https://docs.openshift.com/enterprise/3.0/architecture/additional_concepts/authorization.html#roles
oc adm policy add-cluster-role-to-user view system:serviceaccount:standalone-jenkins:jenkins