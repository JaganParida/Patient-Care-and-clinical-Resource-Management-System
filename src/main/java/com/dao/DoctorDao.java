package com.dao;

import com.db.DBConnect;
import com.entity.Doctor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DoctorDao {
    private Connection conn;

    public DoctorDao() {
        this.conn = DBConnect.getConnection();
    }

    // Register Doctor
    public boolean registerDoctor(Doctor doctor) {
        boolean success = false;
        try {
            String sql = "INSERT INTO doctor(full_name,email,password,specialization,license_number," +
                    "years_of_experience,qualification,phone,department,clinic_address,availability,status)" +
                    " VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, doctor.getFullName());
            ps.setString(2, doctor.getEmail());
            ps.setString(3, doctor.getPassword());
            ps.setString(4, doctor.getSpecialization());
            ps.setString(5, doctor.getLicenseNumber());
            ps.setInt(6, doctor.getYearsOfExperience());
            ps.setString(7, doctor.getQualification());
            ps.setString(8, doctor.getPhone());
            ps.setString(9, doctor.getDepartment());
            ps.setString(10, doctor.getClinicAddress());
            ps.setString(11, doctor.getAvailability());
            ps.setString(12, doctor.getStatus());

            int rows = ps.executeUpdate();
            success = rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    // Login Doctor
    public Doctor loginDoctor(String email, String password) {
        Doctor doctor = null;
        try {
            String sql = "SELECT * FROM doctor WHERE email=? AND password=? AND status='approved'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                doctor = new Doctor();
                doctor.setId(rs.getInt("id"));
                doctor.setFullName(rs.getString("full_name"));
                doctor.setEmail(rs.getString("email"));
                doctor.setSpecialization(rs.getString("specialization"));
                doctor.setQualification(rs.getString("qualification"));
                doctor.setPhone(rs.getString("phone"));
                doctor.setDepartment(rs.getString("department"));
                doctor.setClinicAddress(rs.getString("clinic_address"));
                doctor.setAvailability(rs.getString("availability"));
                doctor.setStatus(rs.getString("status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return doctor;
    }
}
