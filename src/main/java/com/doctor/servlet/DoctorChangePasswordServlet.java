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

@WebServlet("/doctorChangePassword")
public class DoctorChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            HttpSession session = request.getSession();
            Doctor doctor = (Doctor) session.getAttribute("doctorObj");

            if (doctor == null) {
                session.setAttribute("errorMsg", "Please login first!");
                response.sendRedirect("doctor_login.jsp");
                return;
            }

            // Validate password match
            if (!newPassword.equals(confirmPassword)) {
                session.setAttribute("errorMsg", "New passwords do not match!");
                response.sendRedirect("doctor/change_password.jsp");
                return;
            }

            // Verify current password
            DoctorDao doctorDao = new DoctorDao(DBConnect.getConnection());
            Doctor verifiedDoctor = doctorDao.loginDoctor(doctor.getEmail(), currentPassword);

            if (verifiedDoctor == null) {
                session.setAttribute("errorMsg", "Current password is incorrect!");
                response.sendRedirect("doctor/change_password.jsp");
                return;
            }

            // Change password
            boolean success = doctorDao.changePassword(doctor.getId(), newPassword);

            if (success) {
                session.setAttribute("successMsg", "Password changed successfully!");
            } else {
                session.setAttribute("errorMsg", "Password change failed!");
            }

            response.sendRedirect("doctor/change_password.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("errorMsg", "Server error: " + e.getMessage());
            response.sendRedirect("doctor/change_password.jsp");
        }
    }
}