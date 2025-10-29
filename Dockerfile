FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy Maven wrapper files
COPY mvnw .
COPY .mvn .mvn

# Make mvnw executable
RUN chmod +x ./mvnw

# Copy pom.xml and pre-download dependencies
COPY pom.xml .
RUN ./mvnw dependency:go-offline -B

# Copy the rest of the project
COPY src ./src

# Build the app
RUN ./mvnw clean package -DskipTests

# Run the app (auto-detects jar name)
CMD ["sh", "-c", "java -jar target/*.jar"]
