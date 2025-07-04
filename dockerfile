# ---- Step 1: Build Stage ----
FROM maven:3.9.8-eclipse-temurin-8 AS builder

# Set working directory inside container
WORKDIR /app

# Copy all project files
COPY . .

# Build the shaded jar
RUN mvn clean package -DskipTests

# ---- Step 2: Runtime Stage ----
FROM eclipse-temurin:8-jre

# Set working directory for runtime container
WORKDIR /app

# Copy only the fat JAR from the build stage
COPY --from=builder /app/target/javaparser-maven-sample-1.0-SNAPSHOT.jar app.jar

# Define default runtime command
CMD ["java", "-jar", "app.jar"]
