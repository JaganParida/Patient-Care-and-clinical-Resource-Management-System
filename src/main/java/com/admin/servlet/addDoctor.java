package com.admin.servlet;

import java.io.IOException;

import com.dao.DoctorDao;
import com.db.DBConnect;
import com.entity.Doctor;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/addDoctor")
public class addDoctor extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // Get form data from the request
            String fullName = req.getParameter("fullname");
            String dob = req.getParameter("dob");
            String qualification = req.getParameter("qualification");
            String specialist = req.getParameter("specialist");
            String email = req.getParameter("email");
            String mobno = req.getParameter("mobno");
            String password = req.getParameter("password");

            // Create Doctor object using the form data
            Doctor d = new Doctor(fullName, dob, qualification, specialist, email, mobno, password);

            // Create DAO object for database interaction
            DoctorDao dao = new DoctorDao(DBConnect.getConn());

            // Create or get the current session
            HttpSession session = req.getSession();

            // Register the doctor and set appropriate session message
            if (dao.registerDoctor(d)) {
                session.setAttribute("sucMsg", "Doctor Added Successfully");
                resp.sendRedirect("admin/doctor.jsp");
            } else {
                session.setAttribute("errorMsg", "Something went wrong on the server...");
                resp.sendRedirect("admin/doctor.jsp");
            }

        } catch (Exception e) {
            // Handle and print any exception that occurs
            e.printStackTrace();
        }
    }
}
