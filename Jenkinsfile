pipeline {
    agent any

    tools {
        maven 'maven-3'
    }
    

    environment {
        DOCKER_IMAGE = "your-dockerhub-username/demo-k8s-repo"
        KUBECONFIG_CREDENTIALS_ID = "kubeconfig" // Jenkins credential ID for Kubeconfig file
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Verify Maven') {
            steps {
                sh 'mvn --version'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-creds', url: '']) {
                    sh "docker push ${DOCKER_IMAGE}:latest"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS_ID, variable: 'KUBECONFIG')]) {
                    sh "kubectl apply -f k8s/deployment.yaml"
                    sh "kubectl apply -f k8s/service.yaml"
                }
            }
        }
    }
}
