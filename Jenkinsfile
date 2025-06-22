/*
 * Sanjay Mohan Kumar
 * File: Jenkinsfile
 * File Purpose: This file defines the CI/CD pipeline for building the Docker
 * image and deploying it to a Kubernetes cluster.
 */

pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = 'san68bot'
        APP_NAME = 'swe645-webapp'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig'
    }

    stages {
        stage('Checkout from GitHub') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_REGISTRY}/${APP_NAME}:${BUILD_NUMBER} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                        sh "docker push ${DOCKER_REGISTRY}/${APP_NAME}:${BUILD_NUMBER}"
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            agent {
                docker {
                    image 'bitnami/kubectl:1.29'
                    args '--entrypoint=""'
                }
            }
            steps {
                script {
                    withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                        sh "kubectl set image deployment/swe645-deployment swe645-container=${DOCKER_REGISTRY}/${APP_NAME}:${env.BUILD_NUMBER}"
                        sh "kubectl rollout status deployment/swe645-deployment"
                    }
                }
            }
        }
    }

    post {
        always {
            sh "docker logout"
            echo 'Pipeline finished.'
        }
    }
}