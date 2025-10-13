package com.admin.servlet;

import java.io.IOException;

import com.dao.DoctorDao;
import com.db.DBConnect;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/delete_doctor")
public class DeleteDoctor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        try {
            // Get doctor ID from request parameter
            int id = Integer.parseInt(req.getParameter("id").trim());

            // Create DoctorDao instance
            DoctorDao dao = new DoctorDao(DBConnect.getConn());

            // Perform delete operation
            boolean success = dao.deleteDoctor(id);

            if (success) {
                session.setAttribute("sucMsg", "Doctor deleted successfully.");
            } else {
                session.setAttribute("errorMsg", "Something went wrong on the server.");
            }

            // Redirect back to the view doctor page
            resp.sendRedirect("admin/view_doctor.jsp");

        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "Invalid doctor ID format.");
            resp.sendRedirect("admin/view_doctor.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "An unexpected error occurred.");
            resp.sendRedirect("admin/view_doctor.jsp");
        }
    }
}