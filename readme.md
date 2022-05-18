# Spring PetClinic Sample Application with Contrast [![Build Status](https://github.com/spring-projects/spring-petclinic/actions/workflows/maven-build.yml/badge.svg)](https://github.com/spring-projects/spring-petclinic/actions/workflows/maven-build.yml)

## Understanding the Spring Petclinic application with a few diagrams
<a href="https://speakerdeck.com/michaelisvy/spring-petclinic-sample-application">See the presentation here</a>

### Contrast Instrumentation
This repo includes the source code for the Spring PetClinic application. The Jenkinsfile includes a wget to download the agent into the build directory and includes it in the Docker Container when built. 

Specifically modified:

1. The contrast_security.yaml (not included in the repo) has several overrides and flags to enable/disable Assess and Protect, and a few other specific environment variables.
2. The docker-compose.yml includes the path to the contrast_security.yaml (not included), and sets a few other specific environment variables.
3. Three other docker-compose YAMLs depending on what "environment" you're wanting to run: Development, QA, or Production.

contrast_security.yaml example:

api:<br>
&nbsp;&nbsp;url: https://apptwo.contrastsecurity.com/Contrast<br>
&nbsp;&nbsp;api_key: [REDACTED<br>
&nbsp;&nbsp;service_key: [REDACTED]<br>
&nbsp;&nbsp;user_name: [REDACTED]<br>
agent:<br>
&nbsp;&nbsp;java:<br>
&nbsp;&nbsp;&nbsp;&nbsp;standalone_app_name: PetClinic<br>
application:<br>
&nbsp;&nbsp;session_metadata: buildNumber=${BUILD_NUMBER}, committer=Steve Smith<br>

Your contrast_security.yaml file needs to be in the application's root directory.

# Requirements

1. Java JDK 16

## How to build and run

### 1. Building the application from source and Dockerizing it
Building the Spring Boot project will not include the Contrast Agent or the YAML. If you use my Jenkins Pipeline example, it does a wget to obtain the Contrast agent and creates the YAML using Jenkins Secrets).

./mvnw package
docker-compose build

### 2. Running the application 
Starting the Spring Boot application will also start the Contrast Agent.

To run `petclinic`, execute the following command:

docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d

PetCLinic should be accessible at http://ip_address:8989.

#### 3. Building with Jenkins
Included is a sample Jenkinsfile that can be used as a Jenkins Pipeline to build and run the application. The Jenkins Pipeline passes buildNumber as a parameter to the YAML.
