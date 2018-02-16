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
                sh 'eval `ssh-agent -s`'
                sh 'ssh-add'
                sh 'echo $SSH_AUTH_SOCK'
                sh './deploy.sh'
            }
        }
    }
}
