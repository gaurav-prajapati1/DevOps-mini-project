pipeline {
    agent any

    environment {
        APP_DIR = "/opt/DevOps-mini-project"
    }

    stages {

        stage('Check Server') {
            steps {
                sh '''
                    whoami
                    hostname
                    cd ${APP_DIR}
                    pwd
                '''
            }
        }

        stage('Pull Latest Production Code') {
            steps {
                sh '''
                    cd ${APP_DIR}

                    git fetch origin production
                    git pull origin production
                '''
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                sh '''
                    cd ${APP_DIR}

                    docker compose down
                    docker compose up -d --build
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    cd ${APP_DIR}

                    docker compose ps
                    docker ps --filter name=devops-container
                '''
            }
        }
    }
}
