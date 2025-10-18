package com.doctor.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.dao.DoctorDao;
import com.db.DBConnect;
import com.entity.Doctor;

@WebServlet("/updateDoctorProfile")
public class UpdateDoctorProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Get form parameters
            String fullName = request.getParameter("fullName");
            String specialization = request.getParameter("specialization");
            String licenseNumber = request.getParameter("licenseNumber");
            String yearsOfExperienceStr = request.getParameter("yearsOfExperience");
            String qualification = request.getParameter("qualification");
            String phone = request.getParameter("phone");
            String department = request.getParameter("department");
            String clinicAddress = request.getParameter("clinicAddress");
            String[] availabilityArray = request.getParameterValues("availability");

            HttpSession session = request.getSession();
            Doctor doctor = (Doctor) session.getAttribute("doctorObj");

            if (doctor == null) {
                session.setAttribute("errorMsg", "Please login first!");
                response.sendRedirect("doctor_login.jsp");
                return;
            }

            // Convert years of experience
            int yearsOfExperience = 0;
            try {
                yearsOfExperience = Integer.parseInt(yearsOfExperienceStr);
            } catch (NumberFormatException e) {
                session.setAttribute("errorMsg", "Please enter valid years of experience!");
                response.sendRedirect("doctor/edit_profile.jsp");
                return;
            }

            // Process availability
            String availability = "";
            if (availabilityArray != null && availabilityArray.length > 0) {
                availability = String.join(",", availabilityArray);
            }

            // Update doctor object
            doctor.setFullName(fullName);
            doctor.setSpecialization(specialization);
            doctor.setLicenseNumber(licenseNumber);
            doctor.setYearsOfExperience(yearsOfExperience);
            doctor.setQualification(qualification);
            doctor.setPhone(phone);
            doctor.setDepartment(department);
            doctor.setClinicAddress(clinicAddress);
            doctor.setAvailability(availability);

            // Update in database
            DoctorDao doctorDao = new DoctorDao(DBConnect.getConnection());
            boolean success = doctorDao.updateDoctorProfile(doctor);

            if (success) {
                session.setAttribute("doctorObj", doctor); // Update session
                session.setAttribute("successMsg", "Profile updated successfully!");
            } else {
                session.setAttribute("errorMsg", "Profile update failed!");
            }

            response.sendRedirect("doctor/edit_profile.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("errorMsg", "Server error: " + e.getMessage());
            response.sendRedirect("doctor/edit_profile.jsp");
        }
    }
}