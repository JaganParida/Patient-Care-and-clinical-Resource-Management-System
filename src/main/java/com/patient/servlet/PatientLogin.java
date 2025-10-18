package com.patient.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/patient/patientLogin")
public class PatientLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database configuration
    private static final String DB_URL = "jdbc:mysql://localhost:3306/patient_care_crms";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "jagan12@"; // change as needed

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

                String sql = "SELECT id, fullname, email FROM patient WHERE email=? AND password=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, email);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    // ✅ Login successful
                    HttpSession session = request.getSession();
                    session.setAttribute("patientId", rs.getInt("id"));
                    session.setAttribute("patientName", rs.getString("fullname"));
                    session.setAttribute("patientEmail", rs.getString("email"));

                    // Redirect to dashboard (change as per your next page)
                    response.sendRedirect(request.getContextPath() + "/patient/index.jsp");
                } else {
                    // ❌ Invalid credentials
                    request.setAttribute("errorMsg", "Invalid email or password! Please try again.");
                    RequestDispatcher rd = request.getRequestDispatcher("/patient/patient_login.jsp");
                    rd.forward(request, response);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Something went wrong! Please try again later.");
            RequestDispatcher rd = request.getRequestDispatcher("/patient/patient_login.jsp");
            rd.forward(request, response);
        }
    }

    // Optional: To quickly test if servlet mapping works
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().println("PatientLogin servlet working correctly!");
    }
}
