FROM adoptopenjdk/maven-openjdk11

COPY ./target/spring-petclinic-2.6.0-SNAPSHOT.jar /app/petclinic/petclinic-2.6.0.jar
COPY . /app/petclinic
WORKDIR /app/petclinic

EXPOSE 8080

CMD ["java","-javaagent:/app/petclinic/contrast.jar","-jar","/app/petclinic/petclinic-2.6.0.jar"]
