pipeline {
    agent any
        environment {
        //once you sign up for Docker hub, use that user_id here
        registry = "devopsaks20/python-app-ci-cd"
        //- update your credentials ID after creating credentials for connecting to Docker Hub, Dockerhub userID password creation in jenkins
        registryCredential = 'Dockerhub-ID'
        dockerImage = ''
    }
    stages {

        stage ('GIT-checkout') {
            steps {
            checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'Git-hub-ID', url: 'https://github.com/devopsaks20/python-app-ci-cd.git']]])
            }
        }
       
        stage ('Build docker image') {
            steps {
                script {
                dockerImage = docker.build registry + ":$BUILD_NUMBER"
                //dockerImage = docker.build registry + ":$BUILD_NUMBER"

                }
            }
        }
       
		stage('Uploading Docker images into Docker Hub') {
		 steps{   
			 script {
				docker.withRegistry( '', registryCredential ) {
				dockerImage.push()
				}
			}
		  }
		}
		stage ('Kubernetes deployment Deploy') {
        steps {
            script {
                sh 'sed -i "s/tag/${BUILD_NUMBER}/" Sample-Python-App.yaml'
                kubernetesDeploy(
                    configs: 'Sample-Python-App.yaml',
                    kubeconfigId: 'Kube-config-file',
                    enableConfigSubstitution: true
                    )           
               
            }
        }
    }
  
    }  
}
