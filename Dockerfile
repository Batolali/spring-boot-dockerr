# Bruk et OpenJDK 21-bilde som base
FROM openjdk:21-jdk-slim AS build

# Installer Maven
RUN apt-get update && apt-get install -y maven

# Sett arbeidskatalog
WORKDIR /app

# Kopier prosjektfilene
COPY . .

# Bygg prosjektet med Maven
RUN mvn clean install
