pipeline {
    agent any

    environment {
        IMAGE_NAME = "devops-mini-project"
        APP_SERVER = "10.0.2.205"
    }

    stages {

        stage('Build Docker Image') {
            steps {
                dir('app') {
                    sh 'docker build -t $IMAGE_NAME:latest .'
                }
            }
        }

        stage('Transfer Image to Application Server') {
            steps {
                sh '''
                    docker save ${IMAGE_NAME}:latest -o app-image.tar

                    scp app-image.tar ubuntu@${APP_SERVER}:/home/ubuntu/
                '''
            }
        }

        stage('Deploy on Application Server') {
            steps {
                sh '''
                    ssh ubuntu@${APP_SERVER} '
                        docker load -i /home/ubuntu/app-image.tar

                        docker rm -f devops-container || true

                        docker run -d \
                          --name devops-container \
                          -p 80:80 \
                          devops-mini-project:latest

                        rm -f /home/ubuntu/app-image.tar
                    '
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    ssh ubuntu@${APP_SERVER} \
                    "docker ps --filter name=devops-container"
                '''
            }
        }
    }
}