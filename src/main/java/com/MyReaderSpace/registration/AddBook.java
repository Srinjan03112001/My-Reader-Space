package com.MyReaderSpace.registration;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class AddBook
 */

@WebServlet("/add")
public class AddBook extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("b_title");
		String author = request.getParameter("b_author");
		String category = request.getParameter("b_category");
		String price = request.getParameter("b_price");
		String copies = request.getParameter("b_copies");
		
		RequestDispatcher dispatcher = null;
		Connection con = null;
		dispatcher = request.getRequestDispatcher("insert_book.jsp");
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myreaderspace","root","MSSM1234");
			
			PreparedStatement pst1 = con.prepareStatement("select bookid from book where title = ?");
			pst1.setString(1, title);
			ResultSet rs = pst1.executeQuery();
			if(rs.next()) {
				request.setAttribute("status", "book_present");
			}else {
				PreparedStatement pst2 = con.prepareStatement("insert into book(title, author, category, price, copies) values (?,?,?,?,?)");
				pst2.setString(1, title);
				pst2.setString(2, author);
				pst2.setString(3, category);
				pst2.setString(4, price);
				pst2.setString(5, copies);
				
				int rowCnt = pst2.executeUpdate();
				
				if(rowCnt > 0) 
					request.setAttribute("status", "success");
				else
					request.setAttribute("status", "failed");
			}
			dispatcher.forward(request,  response);
			
		} catch(Exception e) {
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
