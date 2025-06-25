# Stage 1: Build the WAR using Maven and Java 11
FROM maven:3.8.5-openjdk-11 AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src
COPY WEB-INF ./WEB-INF
COPY META-INF ./META-INF
COPY assets ./assets
COPY jsp ./jsp
COPY *.jsp .    # index.jsp, my_bookings.jsp, etc.
COPY bus_booking.sql .

RUN mvn clean package -DskipTests

# Stage 2: Deploy to Tomcat
FROM tomcat:9.0-jdk11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=builder /app/target/Bus_Booking_System.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
