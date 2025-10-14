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

@WebServlet("/updateDoctor")
public class UpdateDoctor extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String fullName = req.getParameter("fullname");
            String dob = req.getParameter("dob");
            String qualification = req.getParameter("qualification");
            String specialist = req.getParameter("specialist");
            String email = req.getParameter("email");
            String mobno = req.getParameter("mobno");
            String password = req.getParameter("password");

            int id = Integer.parseInt(req.getParameter("id").trim());

            Doctor d = new Doctor(id, fullName, dob, qualification, specialist, email, mobno, password);

            DoctorDao dao = new DoctorDao(DBConnect.getConn());
            HttpSession session = req.getSession();

            if (dao.updateDoctor(d)) {
                session.setAttribute("sucMsg", "Doctor updated successfully!");
                resp.sendRedirect("admin/view_doctor.jsp");
            } else {
                session.setAttribute("errorMsg", "Something went wrong on the server.");
                resp.sendRedirect("admin/view_doctor.jsp");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            HttpSession session = req.getSession();
            session.setAttribute("errorMsg", "Invalid doctor ID format.");
            resp.sendRedirect("admin/view_doctor.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = req.getSession();
            session.setAttribute("errorMsg", "Server error occurred while updating the doctor.");
            resp.sendRedirect("admin/view_doctor.jsp");
        }
    }
}
