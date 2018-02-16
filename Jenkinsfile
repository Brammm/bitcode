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
                sh 'eval "$(ssh-agent -s)"'
                sh './deploy.sh'
            }
        }
    }
}
