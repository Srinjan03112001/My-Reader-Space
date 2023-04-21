package com.MyReaderSpace.registration;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/memberLogin")
public class MemberLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String muser = request.getParameter("m_user");
		String mpass = request.getParameter("m_pass");
		HttpSession session = request.getSession();
		RequestDispatcher dispatcher = null;
		
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myreaderspace","root","MSSM1234");
			PreparedStatement pst = con.prepareStatement("select * from member where username = ? and password = ?");
			
			pst.setString(1, muser);
			pst.setString(2, mpass);
			
			ResultSet rs= pst.executeQuery();
			if(rs.next()) {
				session.setAttribute("name", rs.getString("name"));
				dispatcher = request.getRequestDispatcher("member_home.jsp");
			}
			else {
				request.setAttribute("status", "failed");
				dispatcher = request.getRequestDispatcher("member_login.jsp");
			}
			dispatcher.forward(request,  response);
			
		} catch(Exception e) {
			
		}
	}

}
