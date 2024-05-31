pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "karthikdevops10/2bcloud-hello-world:latest"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/karthikdevops10/nodejs-hello-world.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }


        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh '''
                    echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin
                    docker push ${DOCKER_IMAGE}
                    '''
                }
            }
        }

        stage('Scale Down Deployment') {
            steps {
                script {
                    sh '''
                    kubectl scale deployment hello-world-node --replicas=0
		            kubectl apply -f k8s
		            kubectl get all
		            sleep 15
                    '''
                }
            }
        }
        
        stage('Access Web API Using HTTP') {
            steps {
                script {
                    def service = 'hello-world-node' // Replace with your service name
                    def url = sh(script: "minikube service ${service} --url", returnStdout: true).trim()
                    echo "Service URL: ${url}"
                    sh "curl ${url}"
                }
            }
        }        
        
    }

    post {
        always {
            cleanWs()
        }
    }
}
