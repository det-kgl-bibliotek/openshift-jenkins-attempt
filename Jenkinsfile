openshift.withCluster() { // Use "default" cluster or fallback to OpenShift cluster detection
    echo "Hello from the project running Jenkins: ${openshift.project()}"

    node('maven') {
        stage('checkout') {
            checkout scm
        }

        stage('Build') {
            sh "mvn clean package"
        }
    }
}