pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'make build'
            }
        }
        stage('deploy') {
            steps {
                sh 'echo $SSH_AUTH_SOCK'
                sh './deploy.sh'
            }
        }
    }
}
