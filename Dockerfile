# Bruk OpenJDK 21 som base image
FROM openjdk:21-jdk-slim AS build

# Installer Maven (via Maven Wrapper, included in the repo)
# We don't need to download mvnw via curl if it's already in your project
RUN apt-get update && apt-get install -y maven

# Sett arbeidskatalog
WORKDIR /app

# Kopier prosjektfilene (inkludert mvnw og pom.xml)
COPY . . 

# Gi mvnw kjørbar tillatelse (hvis ikke allerede satt)
RUN chmod +x ./mvnw

# Bygg prosjektet med Maven Wrapper (det vil bruke mvnw for å bygge)
RUN ./mvnw clean install -DskipTests

# Sett opp produksjonsmiljø
FROM openjdk:21-jdk-slim AS production

# Sett arbeidskatalog
WORKDIR /app

# Kopier bare de nødvendige filene (byggeartefakter fra build stage)
COPY --from=build /app/target/spring-boot-app.jar .

# Start applikasjonen
CMD ["java", "-jar", "spring-boot-app.jar"]
