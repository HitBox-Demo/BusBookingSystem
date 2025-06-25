# Use Tomcat with Java 11
FROM tomcat:9.0-jdk11

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR into the webapps directory
COPY Bus_Booking_System.war /usr/local/tomcat/webapps/ROOT.war

# Expose default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
