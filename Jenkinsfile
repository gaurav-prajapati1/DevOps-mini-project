pipeline {
    agent any

    environment {
        APP_SERVER = "10.0.2.205"
    }

    stages {

        stage('Deploy Application') {
            steps {
                sh '''
                    ssh root@${APP_SERVER} '
                        set -e

                        echo "===== Getting latest production code ====="

                        cd /opt/DevOps-mini-project

                        git fetch origin production
                        git reset --hard origin/production

                        echo "===== Stopping old Docker Compose ====="

                        docker compose down

                        echo "===== Building and starting new Docker Compose ====="

                        docker compose up -d --build

                        echo "===== Deployment completed ====="

                        docker compose ps
                    '
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    ssh root@${APP_SERVER} '
                        echo "===== Docker Containers ====="
                        docker ps

                        echo "===== Website Test ====="
                        curl -I http://localhost
                    '
                '''
            }
        }
    }
}
