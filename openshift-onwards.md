Vi forsøgte også at udforske Jenkins understøttelse af Github Organisations. 

Vi lavede projektet <https://github.com/det-kgl-bibliotek/openshift-standalone-jenkins>, som indeholder opsætningsvejledningen til det framework.

Det vi gør er kort fortalt

* [Vi laver et nyt openshift projekt](https://github.com/det-kgl-bibliotek/openshift-standalone-jenkins/blob/master/1.createStandaloneJenkins.sh) ["jenkins-standalone"](https://openshift-test-01.kb.dk:8443/console/project/standalone-jenkins/overview) med en [jenkins instans](https://jenkins-standalone-jenkins.apps-test.kb.dk/).
* [Vi installerer et Github Access Token i den jenkins instans, så den kan snakke med Github](https://github.com/det-kgl-bibliotek/openshift-standalone-jenkins/blob/master/2.setupGithubAPIToken.sh)
* [Vi opsætter et jenkins job](https://github.com/det-kgl-bibliotek/openshift-standalone-jenkins/blob/master/3.installOrgJob.sh), der scanner <https://github.com/det-kgl-bibliotek> og tilføjer alle projekter/branches der har en Jenkinsfile

Det eneste projekt på <https://github.com/det-kgl-bibliotek> der opfylder kravet om at have en Jenkinsfile er <https://github.com/det-kgl-bibliotek/openshift-sampleproject>

Denne [Jenkinsfile](https://github.com/det-kgl-bibliotek/openshift-sampleproject/blob/master/Jenkinsfile)﻿ gennemfører disse steps

1. Oversæt git repository navn og branch til et lovligt openshift projekt navn
1. slet og opret et openshift projekt med det navn
1. Skift til dette nye projekt
1. Installer en postgres instans
1. Bed Jenkins om en maven node
1. På den maven node, git clone kilde koden fra git repositoriet
1. Byg koden

Denne jenkinsfil er tydeligvis blot et proof of concept.

Vi har to branches, [master](https://github.com/det-kgl-bibliotek/openshift-sampleproject/tree/master)﻿ og [other_branch](https://github.com/det-kgl-bibliotek/openshift-sampleproject/tree/other_branch), så den laver separate jenkins ["projekter"](https://jenkins-standalone-jenkins.apps-test.kb.dk/job/det%20kgl%20bibliotek/job/openshift-sampleproject/) for hver branch. Begge branches har tilfældigvis den samme Jenkinsfil, så de vil hver især lave et branch-specifikt openshift projekt. 

Det interessante her er at der kun er 1 Jenkins instans. Denne jenkins instans håndterer hele bygge processen. Men hvis en kode projekt har brug for at starte noget, f.eks. til integration tests eller for at efterlade en demo instans, så kan den vha. dette lave et openshift projekt med kun de ting i.