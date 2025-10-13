package com.admin.servlet;

import java.io.IOException;

import com.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/adminLogin")
public class AdminLogin extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            HttpSession session = req.getSession();

            if ("admin@gmail.com".equals(email) && "admin".equals(password)) {
                session.setAttribute("adminObj", new User());
                resp.sendRedirect("admin/index.jsp");
            } else {
                session.setAttribute("errorMsg", "Invalid email or password");
                resp.sendRedirect("admin.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = req.getSession();
            session.setAttribute("errorMsg", "Server error during login");
            resp.sendRedirect("admin.jsp");
        }
    }
}