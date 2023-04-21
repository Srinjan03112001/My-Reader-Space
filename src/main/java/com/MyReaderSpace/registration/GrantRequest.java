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

@WebServlet("/grant")
public class GrantRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String[] reqId = request.getParameterValues("req");
		HttpSession session = request.getSession();
		RequestDispatcher dispatcher = null;
		
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myreaderspace","root","MSSM1234");
			PreparedStatement pst = con.prepareStatement("delete from pending_book_requests where request_id= ?");
			if(request.getParameter("l_reject") != null) {
				for(int i=0; i< reqId.length; i++) {
					pst.setString(1,reqId[i]);
					pst.executeUpdate();
				}
			} else if( request.getParameter("l_grant") != null){
				PreparedStatement pst4 = con.prepareStatement("select DATE_ADD(CURDATE(),INTERVAL 14 DAY)");
				ResultSet r = pst4.executeQuery();
				String duedate = null;
				while(r.next()) {
					duedate = r.getString(1);
				}
				PreparedStatement pst2 = con.prepareStatement("select member, bookid from pending_book_requests where request_id = ?");
				
				PreparedStatement pst1 = con.prepareStatement("INSERT INTO book_issue_log(member, bookid, due_date) VALUES(?, ?, ?)");
				PreparedStatement pst3 = con.prepareStatement("update book set copies = copies -1 where bookid=?");

				for(int i=0; i< reqId.length; i++) {
					pst2.setString(1,reqId[i]);
					ResultSet rs=pst2.executeQuery();
					pst.setString(1, reqId[i]);
					while(rs.next()) {
						pst1.setString(1, rs.getString(1));
						pst1.setString(2,  rs.getString(2));
						pst1.setString(3, duedate);
						pst3.setString(1, rs.getString(2));
					}
					pst.executeUpdate();
					pst1.executeUpdate();
					pst3.executeUpdate();
				}

			}
			
			dispatcher = request.getRequestDispatcher("pending_book_requests.jsp");
			dispatcher.forward(request,  response);
			
		} catch(Exception e) {
			
			out.println(e);
			
		}
	}

}
