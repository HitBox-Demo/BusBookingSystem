package com.busbooking.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // Default values if environment variables are not set
    private static final String DEFAULT_URL =
        "jdbc:mysql://localhost:3306/busbooking?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASS = "admin";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL Driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        String url = System.getenv("DB_URL") != null ? System.getenv("DB_URL") : DEFAULT_URL;
        String user = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : DEFAULT_USER;
        String pass = System.getenv("DB_PASS") != null ? System.getenv("DB_PASS") : DEFAULT_PASS;

        return DriverManager.getConnection(url, user, pass);
    }
}
