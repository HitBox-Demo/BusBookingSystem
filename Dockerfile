# Stage 1: Build the application with Maven and Java 11
FROM maven:3.8.5-openjdk-11 AS build

WORKDIR /app

# Copy Maven files and source code
COPY pom.xml .
COPY src ./src

# Build WAR without tests
RUN mvn clean package -DskipTests

# Stage 2: Deploy the WAR with Tomcat and Java 11
FROM tomcat:9.0-jdk11

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR from the build stage
COPY --from=build /app/target/Bus_Booking_System.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
