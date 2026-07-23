pipeline {
    agent any

    environment {
        IMAGE_NAME = "devops-mini-project"
    }

    stages {

        stage('Clone Repository') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('app') {
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker rm -f devops-container || true

                docker run -d \
                  --name devops-container \
                  -p 80:80 \
                  $IMAGE_NAME
                '''
            }
        }

    }
}