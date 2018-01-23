openshift.withCluster() { // Use "default" cluster or fallback to OpenShift cluster detection
    echo "Hello from the project running Jenkins: ${openshift.project()}"

    def projectName = BRANCH_NAME

    stage('environment') {
        sh 'env > env.txt'
        for (String i : readFile('env.txt').split("\r?\n")) {
            println i
        }

    }

    stage('Deploy test') {
        def created = openshift.newApp( 'postgresql-ephemeral', "--name='${JOB_NAME}-postgres'", "--labels='${JOB_NAME}'" )
        // This Selector exposes the same operations you have already seen.
        // (And many more that you haven't!).
        echo "new-app created ${created.count()} objects named: ${created.names()}"

        echo created.describe()

//            for ( obj in created ) {
//                obj.metadata.labels[ "build" ] = JOB_NAME
//            }


//            JOB_NAME=det-kgl-bibliotek/openshift-jenkins-attempt/master
    }


    node('maven') {
//        stage('checkout') {
//            checkout scm
//        }
//
//        stage('Build') {
//            sh "mvn clean package"
//        }

    }
}