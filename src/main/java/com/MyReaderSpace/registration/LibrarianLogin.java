package com.MyReaderSpace.registration;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/LibLogin")
public class LibrarianLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String luser = request.getParameter("l_user");
		String lpass = request.getParameter("l_pass");
		HttpSession session = request.getSession();
		RequestDispatcher dispatcher = null;
		
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myreaderspace","root","MSSM1234");
			PreparedStatement pst = con.prepareStatement("select * from librarian where username = ? and password = ?");
			
			pst.setString(1, luser);
			pst.setString(2, lpass);
			
			ResultSet rs= pst.executeQuery();
			if(rs.next()) {
				session.setAttribute("lib_name", rs.getString("username"));
				dispatcher = request.getRequestDispatcher("librarian_home.jsp");
			}
			else {
				request.setAttribute("status", "failed");
				dispatcher = request.getRequestDispatcher("librarian_login.jsp");
			}
			dispatcher.forward(request,  response);
			
		} catch(Exception e) {
			PrintWriter out = response.getWriter();
			out.println(e);
		}
	}

}
