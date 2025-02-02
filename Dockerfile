# Bruk OpenJDK 21 som base image
FROM openjdk:21-jdk-slim AS build

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
# Endre filnavnet til det som Maven har generert: coursera-0.0.1-SNAPSHOT.jar
COPY --from=build /app/target/coursera-0.0.1-SNAPSHOT.jar .

# Start applikasjonen
CMD ["java", "-jar", "coursera-0.0.1-SNAPSHOT.jar"]
