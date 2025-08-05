# Use official OpenJDK image with JDK 17
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the built jar file (after 'mvn package')
COPY target/demo-k8s-repo-1.0.0.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java", "-jar", "app.jar"]
