<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file = "librarian_header_2.jsp" %>
    <%@page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Book Details</title>
<link rel="stylesheet" type="text/css" href="css/global_styles.css" />
		<link rel="stylesheet" type="text/css" href="css/form_styles.css" />
		<link rel="stylesheet" href="librarian/css/insert_book_style.css">
</head>
<body>
<%! 
	String def(String cat1, String cat2){
	if(cat1.equals(cat2)){
		return "selected";
	}
	return null;
}
%>
<%! String title, author, category, price, copies = null; %>
<%
String bookid = request.getParameter("bookid");
Connection con = null;
Statement st = null;
ResultSet rs= null;
try{
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myreaderspace","root","MSSM1234");
	PreparedStatement pst = con.prepareStatement("select title, author, category, price, copies from book where bookid = ?");
	pst.setString(1,bookid);
	
	rs = pst.executeQuery();
	
	while(rs.next()){
		title = rs.getString(1);
		author = rs.getString(2);
		category = rs.getString(3);
		price = rs.getString(4);
		copies = rs.getString(5);
	}
	
} catch(Exception e){}
%>
	<form class="cd-form" method="POST" action="updateBook">
			<legend>Enter book details</legend>
			
				<div class="error-message" id="error-message">
					<p id="error"></p>
				</div>
				
				
					<input class="b-title" type="hidden" name="b_title" value="<%= title %>" required />
				
				<div class="icon">
					<input class="b-author" type="text" name="b_author" value="<%= author %>" required />
				</div>
				
				<div>
				<h4>Category</h4>
				
					<p class="cd-select icon">
						<select class="b-category" name="b_category">
							<option <%= def(category,"Fiction") %>>Fiction</option>
							<option <%= def(category,"Non-fiction") %>>Non-fiction</option>
							<option <%= def(category,"Education") %>>Education</option>
						</select>
					</p>
				</div>
				
				<div class="icon">
					<input class="b-price" type="number" name="b_price" value="<%= price %>" required />
				</div>
				
				<div class="icon">
					<input class="b-copies" type="number" name="b_copies" value="<%= copies %>" required />
				</div>
				
				<br />
				<input class="b-isbn" type="submit" name="b_add" value="Update Details" />
		</form>
		
</body>
</html>