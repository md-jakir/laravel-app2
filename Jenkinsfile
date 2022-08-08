def appimage
pipeline{
    agent any
    environment {
        SERVICE_NAME = "app1"
        CONTAINER_NAME = "laravel-app2"
        DOCKER_USERNAME= "mdjakir"
        VERSION="1.0.0"
        TAG_NAME="${BUILD_NUMBER}"
        registry= "mdjakir/${JOB_BASE_NAME}"
        BRANCH_NAME="master"
        GIT_REPO="https://github.com/md-jakir/laravel-app1.git"
    }
	
    stages{
        stage('SCM'){
            steps{
                git branch: "${env.BRANCH_NAME}",url: "${env.GIT_REPO}"
            }
        }
        
        stage('Build'){
            steps{
                script {
                    appimage = docker.build("$env.registry")}
            }
        }
        
        stage('Push'){
            environment {
               registryCredential = 'mydockerhub'
           }
           
            steps{
                script {
                   docker.withRegistry( '', "$env.registryCredential" ) {
                       appimage.push("$TAG_NAME")
                   }
               }
            }
        }

        stage('Deploy') {
            steps{
                kubernetesDeploy configs: 'deploy/app1-deploy.yml', enableConfigSubstitution: true, kubeconfigId: 'K8S-KUBE'
            }
        }
        
        stage('Cleaning up') { 

			steps {
				sh "docker rmi $env.registry:$TAG_NAME"
			}
        }
    }
    
    post { 
        always { 
            cleanWs()
        }
    }
}
