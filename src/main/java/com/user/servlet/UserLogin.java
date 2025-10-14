package com.user.servlet;

import java.io.IOException;
import com.dao.UserDao;
import com.db.DBConnect;
import com.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/userLogin") // Make sure this matches your form action
public class UserLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String email = req.getParameter("email").trim();
        String password = req.getParameter("password").trim();

        HttpSession session = req.getSession();

        UserDao dao = new UserDao(DBConnect.getConn());
        User user = dao.login(email, password);

        if (user != null) {
            session.setAttribute("userObj", user); // Store user in session
            resp.sendRedirect("index.jsp");        // Redirect to homepage
        } else {
            session.setAttribute("errorMsg", "Invalid email or password");
            resp.sendRedirect("login.jsp");        // Redirect back to login page
        }
    }
}
