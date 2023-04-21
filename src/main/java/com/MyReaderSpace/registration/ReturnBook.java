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

@WebServlet("/return")
public class ReturnBook extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] bookids = request.getParameterValues("bookids");
		PrintWriter out= response.getWriter();
		RequestDispatcher dispatcher = null;
		Connection con = null;
		dispatcher = request.getRequestDispatcher("member_my_books.jsp");
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myreaderspace","root","MSSM1234");
			PreparedStatement pst1 = con.prepareStatement("delete from book_issue_log where bookid= ?");
			PreparedStatement pst2 = con.prepareStatement("update book set copies = copies+1 where bookid= ?");
			
			for(int i=0; i<bookids.length; i++) {
				pst1.setString(1, bookids[i]);
				pst2.setString(1, bookids[i]);
				int row =pst1.executeUpdate();
				pst2.executeUpdate();
				if(row>0)
					request.setAttribute("status", "success");
				else
					request.setAttribute("status", "failed");
			}
			dispatcher.forward(request,  response);
		}
		catch(Exception e) {
			out.println(e);
		}
	}

}
