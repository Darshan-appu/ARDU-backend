FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy Maven wrapper files first
COPY mvnw .
COPY .mvn .mvn

# ✅ Make the mvnw script executable
RUN chmod +x ./mvnw

# Copy the pom.xml and download dependencies (for build caching)
COPY pom.xml .
RUN ./mvnw dependency:go-offline -B

# Copy the rest of the project
COPY src ./src

# Build the app
RUN ./mvnw clean package -DskipTests

# Run the JAR
CMD ["java", "-jar", "target/your-app-name.jar"]
