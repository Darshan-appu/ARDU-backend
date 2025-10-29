# Use a base image with Java and Maven
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy the Maven wrapper and pom.xml first
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Download dependencies (for caching)
RUN ./mvnw dependency:go-offline -B

# Copy the project source
COPY src ./src

# Build the application
RUN ./mvnw clean package -DskipTests

# Run the JAR file
CMD ["java", "-jar", "target/*.jar"]
