# Bruk OpenJDK 21 som base image
FROM openjdk:21-jdk-slim AS build

# Installer Maven Wrapper
RUN apt-get update && apt-get install -y curl && \
    curl -o mvnw https://raw.githubusercontent.com/takari/maven-wrapper/master/maven-wrapper.jar && \
    chmod +x mvnw

# Sett arbeidskatalog
WORKDIR /app

# Kopier prosjektfilene
COPY . .

# Bygg prosjektet med Maven Wrapper
RUN ./mvnw clean install -DskipTests

# Sett opp produksjonsmiljø
FROM openjdk:21-jdk-slim AS production

# Sett arbeidskatalog
WORKDIR /app

# Kopier bare de nødvendige filene (byggeartefakter)
COPY --from=build /app/target/spring-boot-app.jar .

# Start applikasjonen
CMD ["java", "-jar", "spring-boot-app.jar"]
