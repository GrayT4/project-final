FROM openjdk:17
LABEL authors="GrayT4"
WORKDIR app
ARG JAR=target/*.jar
COPY ${JAR} /app/jira-1.0.jar
COPY resources ./resources
ENTRYPOINT ["java", "-jar", "/app/jira-1.0.jar"]