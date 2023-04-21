<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file = "librarian_header_2.jsp" %>
    <%@page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Book Requests</title>
<link rel="stylesheet" type="text/css" href="css/global_styles.css">
<link rel="stylesheet" type="text/css" href="css/custom_checkbox_style.css">
<link rel="stylesheet" type="text/css" href="librarian/css/pending_book_requests_style.css">
</head>
<body>
<%
Connection conn = null;
Statement st = null;
ResultSet rs, rs1= null;
try{
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myreaderspace","root","MSSM1234");
	st = conn.createStatement();
	
	PreparedStatement pst = conn.prepareStatement("select title from book where bookid=?");
	String qry="select * from pending_book_requests";
	rs=st.executeQuery(qry);
	
		%>
		<form class='cd-form' method='POST' action='grant'>
		<legend>Pending book requests</legend>
		<div class='error-message' id='error-message'>
				<p id='error'></p>
			</div>
			<table width='100%' cellpadding=10 cellspacing=10>
				<tr>
					<th></th>
					<th>Username<hr></th>
					<th>Book ID<hr></th>
					<th>Title<hr></th>
					<th>Time<hr></th>
				</tr>
	<%
		int i=0;
		while(rs.next()){
			
			pst.setString(1,rs.getString(3));
			rs1 = pst.executeQuery();
			i++;
			rs1.next();
			out.println("<tr>");
			out.println("<td><label class='control control--checkbox'><input type='checkbox' name='req' value='"+rs.getString(1)+"' /><div class='control__indicator'></div></label></td>");
			out.println("<td> "+rs.getString(2)+"<hr></td>");
			out.println("<td> "+rs.getString(3)+"<hr></td>");
			out.println("<td> "+rs1.getString(1)+"<hr></td>");
			out.println("<td> "+rs.getString(4)+"<hr></td>");
			out.println("</tr>");
		}
		
		if(i==0){
			out.println("<h2 align='center'>No requests pending</h2>");
		}else{
			%>
			</table>
			<br /><br /><div style='float: right;'>
			<input type='submit' value='Reject selected' name='l_reject'/>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type='submit' value='Grant selected' name='l_grant'/>
			</div>
			</form>
			<%
		}

}catch(Exception e){}
%>
</body>
</html>