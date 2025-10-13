package com.admin.servlet;

import java.io.IOException;

import com.dao.SpecialistDao;
import com.db.DBConnect;
import com.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/addSpecialist")
public class addSpecialist extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		// Get the specialist name from the request
		String speciName = req.getParameter("specName");

		// Create DAO object for database operations
		SpecialistDao dao = new SpecialistDao(DBConnect.getConn());

		// Add the specialist to the database
		boolean f = dao.addSpecialist(speciName);

		// Get the current session
		HttpSession session = req.getSession();

		// Set session messages based on operation result
		if (f) {
			session.setAttribute("sucMsg", "Specialist added successfully");
			resp.sendRedirect("admin/index.jsp");
		} else {
			session.setAttribute("errorMsg", "Something went wrong on server");
			resp.sendRedirect("admin/index.jsp");
		}
	}
}
