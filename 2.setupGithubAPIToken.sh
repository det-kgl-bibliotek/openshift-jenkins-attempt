#!/usr/bin/env bash

set -e
set -x
username=$(grep "username" githubAPIToken.yaml | cut -d':' -f2 | xargs echo)
apiToken=$(grep "\Wtoken:" githubAPIToken.yaml | cut -d':' -f2 | xargs echo)

#https://github.com/openshift/origin/issues/6807#issuecomment-175426439
#ocToken=$(oc get sa/jenkins --template='{{range .secrets}}{{ .name }} {{end}}' | xargs -n 1 oc get secret --template='{{ if .data.token }}{{ .data.token }}{{end}}' | head -n 1 | base64 -d -)

ocToken=$(oc whoami --show-token)


#https://stackoverflow.com/a/37998865/4527948
curl \
    --header "Authorization: Bearer $ocToken" \
    -X POST \
    --insecure \
    'https://jenkins-standalone-jenkins.apps-test.kb.dk/credentials/store/system/domain/_/createCredentials' \
    --data-urlencode \
'json={
  "": "0",
  "credentials": {
    "scope": "GLOBAL",
    "id": "github-api-token",
    "username": "'$username'",
    "password": "'$apiToken'",
    "description": "github api token",
    "$class": "com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl"
  }
}'