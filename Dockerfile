# Stage 1: Build the application with Maven
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /build

# Copy Maven pom.xml and the source code
COPY ./pom.xml ./
COPY ./src ./src

# Build the application and skip tests for faster build
RUN mvn clean package -DskipTests

# Stage 2: Set up the runtime environment
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copy the packaged jar from the build stage to the runtime stage
COPY --from=build /build/target/*.jar app.jar

# Expose the port that the Spring Boot app will run on
EXPOSE 80

# Run the Spring Boot application
CMD ["java", "-jar", "app.jar"]
