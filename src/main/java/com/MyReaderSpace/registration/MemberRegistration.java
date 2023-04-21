package com.MyReaderSpace.registration;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/memberRegister")
public class MemberRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String muser = request.getParameter("m_user");
		String mpass = request.getParameter("m_pass");
		String mname = request.getParameter("m_name");
		String memail = request.getParameter("m_email");
		String mbalance = request.getParameter("m_balance");
		
		RequestDispatcher dispatcher = null;
		Connection con = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myreaderspace","root","MSSM1234");
			PreparedStatement pst1 = con.prepareStatement("select username,name from member where username=? or name=? or email=?");
			pst1.setString(1, muser);
			pst1.setString(2, mname);
			pst1.setString(3, memail);
			ResultSet rs = pst1.executeQuery();
			if(!rs.next()){
				PreparedStatement pst2 = con.prepareStatement("insert into member(username, password, name, email, balance) values (?,?,?,?,?)");
				pst2.setString(1, muser);
				pst2.setString(2, mpass);
				pst2.setString(3, mname);
				pst2.setString(4, memail);
				pst2.setString(5, mbalance);
				int rowCnt = pst2.executeUpdate();
				request.setAttribute("status", "registered");
				dispatcher = request.getRequestDispatcher("member_login.jsp");
			}else {
				request.setAttribute("status", "failed");
				dispatcher = request.getRequestDispatcher("member_register.jsp");
			}
			
			dispatcher.forward(request,  response);
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
