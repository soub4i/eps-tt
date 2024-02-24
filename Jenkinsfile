
// This is a declarative pipeline script that will be used by Jenkins to build, scan, push and deploy the web-app

pipeline {
    agent any
    def app
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                script {
                   app = docker.build("soubai/web-app")
                }

            }
        }
        stage('Scan') {
            steps {
                script {
                    def res = sh(script: 'trivy --severity HIGH --exit-code 1 web-app', returnStatus: true)
                    if (res != 0) {
                        error 'High severity vulnerabilities found, stopping the pipeline'
                    }
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        app.push("latest")
                    }   
                }
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                        if kubectl get deployments | grep web-server
                        then
                            kubectl set image deployment web-server web-server=soubai/web-app:latest
                            kubectl rollout restart deployment web-server
                        else
                            kubectl apply -f manifests/deployment.yaml
                        fi
                    '''
            }
        }
    }
}