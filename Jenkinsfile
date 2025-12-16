pipeline {
    agent any
    environment {
        DEV_REPO = "bvpallavan/dev"
        PROD_REPO = "bvpallavan/prod"
        IMAGE_NAME = "devops-tasks-app"
        DOCKERHUB_CREDENTIALS = 'dockerhub-creds'  // ID from Jenkins credentials
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/BVPallavan/devops-build.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${env.BRANCH_NAME} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIALS,
                                                      usernameVariable: 'DOCKER_USER',
                                                      passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                        
                        if (env.BRANCH_NAME == 'dev') {
                            sh "docker tag ${IMAGE_NAME}:${env.BRANCH_NAME} ${DEV_REPO}:${env.BRANCH_NAME}"
                            sh "docker push ${DEV_REPO}:${env.BRANCH_NAME}"
                        } else if (env.BRANCH_NAME == 'master') {
                            sh "docker tag ${IMAGE_NAME}:${env.BRANCH_NAME} ${PROD_REPO}:${env.BRANCH_NAME}"
                            sh "docker push ${PROD_REPO}:${env.BRANCH_NAME}"
                        }
                    }
                }
            }
        }

        stage('Deploy') {
            when {
                branch 'master'
            }
            steps {
                script {
                    // Example deployment: run container on server
                    sh """
                    docker stop ${IMAGE_NAME} || true
                    docker rm ${IMAGE_NAME} || true
                    docker run -d --name ${IMAGE_NAME} -p 80:80 ${PROD_REPO}:master
                    """
                }
            }
        }
    }
}
