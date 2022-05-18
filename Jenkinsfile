pipeline {
  agent any
  environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub')
	    }
  tools {
        jdk "JDK 16"
    }
    stages {
      stage('1: Download') {
        steps{
            script{
                echo "Clean first"
                sh 'rm -rf *'
                echo "Download from source."
                sh 'git clone https://github.com/contraster-steve/spring-petclinic'
                }
            }
        }
      stage('2: Contrast') {
        steps{
            withCredentials([string(credentialsId: 'AUTH_HEADER', variable: 'AUTH_HEADER'), string(credentialsId: 'API_KEY', variable: 'api_key'), string(credentialsId: 'SERVICE_KEY', variable: 'service_key'), string(credentialsId: 'USER_NAME', variable: 'user_name')]) {
                script{
                    echo "Build YAML file."
                    sh 'pwd'
                    sh 'echo "api:\n  url: https://apptwo.contrastsecurity.com/Contrast\n  api_key: ${api_key}\n  service_key: ${service_key}\n:  user_name: ${user_name}\nagent:\n  java:\n    standalone_app_name: PetClinic\napplication:\n  session_metadata: "buildNumber=${BUILD_NUMBER}, committer=Steve Smith"" >> ./spring-petclinic/contrast_security.yaml'
                    sh 'chmod 755 ./spring-petclinic/contrast_security.yaml'
                    echo "Download Agent"
                    sh 'sudo wget -O ./spring-petclinic/contrast.jar https://repo1.maven.org/maven2/com/contrastsecurity/contrast-agent/3.14.0.26897/contrast-agent-3.14.0.26897.jar'
                }
            }
        }
      }            
      stage('3: Build Images') {
        steps{
            script{
                echo "Build eShopOnWeb."
                dir('./spring-petclinic/') {
                sh './mvnw package'
                sh 'docker-compose build'
                    }
                }
            }
        }        
    stage('4: Deploy') {
        steps{
            script{
            echo "Run Dev here."
            dir('./spring-petclinic/') {
                sh 'docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d'
                    }
                }
            }
        }
    }
}    
