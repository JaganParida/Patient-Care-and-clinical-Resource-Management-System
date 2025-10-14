package com.user.servlet;

import java.io.IOException;

import com.dao.AppointmentDao;
import com.db.DBConnect;
import com.entity.Appointments;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/appAppointment")
public class AppointmentServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		try {
			int userId = Integer.parseInt(req.getParameter("userid").trim());
			String fullname = req.getParameter("fullname");
			String gender = req.getParameter("gender");
			String age = req.getParameter("age");
			String appoint_date = req.getParameter("appoint_date");
			String email = req.getParameter("email");
			String phno = req.getParameter("phno");
			String diseases = req.getParameter("diseases");
			int doctor_id = Integer.parseInt(req.getParameter("doct"));
			String address = req.getParameter("address");

			// Create Appointment object
			Appointments ap = new Appointments(
					userId, fullname, gender, age, appoint_date,
					email, phno, diseases, doctor_id, address, "pending");

			AppointmentDao dao = new AppointmentDao(DBConnect.getConn());
			HttpSession session = req.getSession();

			boolean success = dao.addAppointment(ap);

			if (success) {
				session.setAttribute("succMsg", "Appointment booked successfully!");
			} else {
				session.setAttribute("errorMsg", "Something went wrong on the server!");
			}

			resp.sendRedirect("user_appointment.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			HttpSession session = req.getSession();
			session.setAttribute("errorMsg", "Invalid input or server error!");
			resp.sendRedirect("user_appointment.jsp");
		}
	}
}