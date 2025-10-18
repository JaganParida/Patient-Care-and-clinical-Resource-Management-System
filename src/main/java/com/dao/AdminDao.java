package com.dao;

import com.entity.Admin;
import java.sql.*;

public class AdminDao {
    private Connection conn;

    public AdminDao() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/patient_care_crms","root","jagan12@");
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    // Register Admin
    public boolean registerAdmin(Admin admin) {
        boolean result = false;
        try {
            String sql = "INSERT INTO admin(fullName, employeeId, department, position, email, phone, password, accessLevel) VALUES(?,?,?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, admin.getFullName());
            ps.setString(2, admin.getEmployeeId());
            ps.setString(3, admin.getDepartment());
            ps.setString(4, admin.getPosition());
            ps.setString(5, admin.getEmail());
            ps.setString(6, admin.getPhone());
            ps.setString(7, admin.getPassword()); // optionally hash password here
            ps.setString(8, admin.getAccessLevel());

            int i = ps.executeUpdate();
            if(i > 0) result = true;

        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // Admin login
    public Admin adminLogin(String email, String password) {
        Admin admin = null;
        try {
            String sql = "SELECT * FROM admin WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setFullName(rs.getString("fullName"));
                admin.setEmployeeId(rs.getString("employeeId"));
                admin.setDepartment(rs.getString("department"));
                admin.setPosition(rs.getString("position"));
                admin.setEmail(rs.getString("email"));
                admin.setPhone(rs.getString("phone"));
                admin.setPassword(rs.getString("password"));
                admin.setAccessLevel(rs.getString("accessLevel"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }
        return admin;
    }
}
