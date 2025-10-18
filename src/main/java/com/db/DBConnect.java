package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {

    private static Connection conn;

    // Get database connection
    public static Connection getConnection() {
        try {
            if (conn == null || conn.isClosed()) {
                // 1. Load MySQL JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // 2. Database URL, username, password
                String url = "jdbc:mysql://localhost:3306/patient_care_crms"; // change database name
                String username = "root"; // your DB username
                String password = "jagan12@"; // your DB password

                // 3. Get connection
                conn = DriverManager.getConnection(url, username, password);
            }
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver not found");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Database connection error");
            e.printStackTrace();
        }

        return conn;
    }

    // Close connection (optional)
    public static void closeConnection() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
