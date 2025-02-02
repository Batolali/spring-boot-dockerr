# Start fra et offisielt OpenJDK-bilde
FROM openjdk:21-jdk

# Sett arbeidskatalogen til /app
WORKDIR /app

# Kopier .jar-filen til containeren
COPY target/coursera-0.0.1-SNAPSHOT.jar /app/spring-boot-app.jar

# Kjør applikasjonen
CMD ["java", "-jar", "/app/spring-boot-app.jar"]
