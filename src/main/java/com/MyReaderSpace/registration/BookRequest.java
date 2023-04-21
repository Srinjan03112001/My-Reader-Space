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
import java.sql.SQLException;

@WebServlet("/BookReq")
public class BookRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String bookid = request.getParameter("rd_book");
		String muser = (String) session.getAttribute("name");
		RequestDispatcher dispatcher = null;
		Connection con = null;
		int cnt=0;
		
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myreaderspace","root","MSSM1234");
				dispatcher = request.getRequestDispatcher("member_home.jsp");
					PreparedStatement pst1  = con.prepareStatement("select bookid from book_issue_log where bookid = ?");
					pst1.setString(1, bookid);
					PreparedStatement pst2 = con.prepareStatement("select bookid from book_issue_log where member = ?");
					pst2.setString(1,muser);
					PreparedStatement pst3 = con.prepareStatement("select * from pending_book_requests where member = ?");
					pst3.setString(1,muser);
					PreparedStatement pst = con.prepareStatement("insert into pending_book_requests(member, bookid) values (?,?)");
					pst.setString(1, muser);
					pst.setString(2, bookid);
					ResultSet rs = pst1.executeQuery();					
					ResultSet rs1 = pst2.executeQuery();
					ResultSet rs2 = pst3.executeQuery();
					while(rs1.next()) {
						cnt++;
					}
					
					while(rs2.next()) {
						cnt++;
					}
					if(cnt==3) {
						request.setAttribute("status", "no_more_books");
						dispatcher.forward(request,  response);
					}
					else {
						if(rs.next()) {
							request.setAttribute("status", "book_present");
							dispatcher.forward(request,  response);
						}else {
							int rowCnt = pst.executeUpdate();
							if(rowCnt > 0) {
								request.setAttribute("status", "success");
								dispatcher.forward(request,  response);
							}else {
								request.setAttribute("status", "failed");
								dispatcher.forward(request,  response);
							}
						}
					}
					
				
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
