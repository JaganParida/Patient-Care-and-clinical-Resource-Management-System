package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import com.entity.Patient;

public class PatientDao {
    private Connection conn;

    public PatientDao(Connection conn) {
        this.conn = conn;
    }

    public boolean registerPatient(Patient p) {
        boolean f = false;
        try {
            String sql = "INSERT INTO patient(fullname, email, password, dob, gender, phone, bloodGroup, address, emergencyContactName, emergencyContactPhone) "
                       + "VALUES(?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, p.getFullname());
            ps.setString(2, p.getEmail());
            ps.setString(3, p.getPassword());
            ps.setString(4, p.getDob());
            ps.setString(5, p.getGender());
            ps.setString(6, p.getPhone());
            ps.setString(7, p.getBloodGroup());
            ps.setString(8, p.getAddress());
            ps.setString(9, p.getEmergencyContactName());
            ps.setString(10, p.getEmergencyContactPhone());

            int i = ps.executeUpdate();
            if (i == 1) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
