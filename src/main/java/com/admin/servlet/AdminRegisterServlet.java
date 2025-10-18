package com.admin.servlet;

import com.dao.AdminDao;
import com.entity.Admin;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin_register")
public class AdminRegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String employeeId = request.getParameter("employeeId");
        String department = request.getParameter("department");
        String position = request.getParameter("position");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String accessLevel = request.getParameter("accessLevel");

        Admin admin = new Admin(fullName, employeeId, department, position, email, phone, password, accessLevel);

        AdminDao dao = new AdminDao();
        boolean flag = dao.registerAdmin(admin);

        if (flag) {
            response.sendRedirect("admin_login.jsp?msg=Signup+successful.+Please+login.");
        } else {
            response.sendRedirect("admin_signup.jsp?error=Registration+failed.+Try+again.");
        }
    }
}
