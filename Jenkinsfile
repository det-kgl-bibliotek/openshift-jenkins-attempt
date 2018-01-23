openshift.withCluster() { // Use "default" cluster or fallback to OpenShift cluster detection
    echo "Hello from the project running Jenkins: ${openshift.project()}"

    def projectName=BRANCH_NAME

    stage('environment') {
        echo env
    }

    openshift.withProject(projectName) {
        node('maven') {
            stage('checkout') {
                checkout scm
            }

            stage('Build') {
                sh "mvn clean package"
            }

            stage('Deploy test') {

            }
        }
    }
}