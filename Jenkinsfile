// node {

//     checkout scm

//     env.DOCKER_API_VERSION="1.23"
    
//     sh "git rev-parse --short HEAD > commit-id"

//     tag = readFile('commit-id').replace("\n", "").replace("\r", "")
//     appName = "hello-kenzan"
//     registryHost = "127.0.0.1:30400/"
//     imageName = "${registryHost}${appName}:${tag}"
//     env.BUILDIMG=imageName

//     stage "Build"
    
//         sh "docker build -t ${imageName} -f applications/hello-kenzan/Dockerfile applications/hello-kenzan"
    
//     stage "Push"

//         sh "docker push ${imageName}"

//     stage "Deploy"

//         sh "sed 's#127.0.0.1:30400/hello-kenzan:latest#'$BUILDIMG'#' applications/hello-kenzan/k8s/deployment.yaml | kubectl apply -f -"
//         sh "kubectl rollout status deployment/hello-kenzan"
// }


pipeline {
    agent any
    environment {
        DOCKER_API_VERSION = "1.23"
        appName = "hello-kenzan"
        registryHost = "127.0.0.1:30400/"
        deploymentName = "hello-kenzan"
        deploymentFile = "applications/hello-kenzan/k8s/deployment.yaml"
    }
    stages {
        stage("Checkout") {
            steps {
                checkout scm
            }
        }
        stage("Build") {
            steps {
                sh "git rev-parse --short HEAD > commit-id"
                script {
                    tag = readFile('commit-id').trim()
                    imageName = "${registryHost}${appName}:${tag}"
                    env.BUILDIMG = imageName
                }
                // sh 'sudo apt-get update && sudo apt-get install -y docker.io'
                sh "docker build -t ${env.BUILDIMG} -f applications/hello-kenzan/Dockerfile applications/hello-kenzan"
            }
        }
        stage("Push") {
            steps {
                sh "docker push ${env.BUILDIMG}"
            }
        }
        stage("Deploy") {
            steps {
                sh "sed -i 's|${registryHost}${appName}:latest|${env.BUILDIMG}|g' ${deploymentFile}"
                sh "kubectl apply -f ${deploymentFile}"
                sh "kubectl rollout status deployment/${deploymentName}"
            }
        }
    }
}