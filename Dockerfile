FROM adoptopenjdk/maven-openjdk11 as installer

COPY . /petclinic
WORKDIR /petclinic

FROM adoptopenjdk/maven-openjdk11
WORKDIR /petclinic
COPY --from=installer /petclinic /app/petclinic
EXPOSE 8080

EXPOSE 8080

CMD ["java","-javaagent:/app/petclinic/contrast.jar","-jar","/app/petclinic/target/*.jar"]
