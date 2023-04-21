<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file = "librarian_header_2.jsp" %>
    <%@page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Book Details</title>
		<link rel="stylesheet" type="text/css" href="css/global_styles.css">
		<link rel="stylesheet" type="text/css" href="member/css/home_style.css">
		<link rel="stylesheet" type="text/css" href="css/custom_radio_button_style.css">
</head>
<body>
	<input type="hidden" id="status" value="<%= request.getAttribute("status")%>">
		<form class='cd-form' method='POST' action='update.jsp'>
		<legend>Available books</legend>
		<div class='error-message' id='error-message'>
			<p id='error'></p>
		</div>
		<table width='100%' cellpadding=10 cellspacing=10>
		
		<tr>
			<th></th>
			<th>Book ID<hr></th>
			<th>Title<hr></th>
			<th>Author<hr></th>
			<th>Category<hr></th>
			<th>Price<hr></th>
			<th>Copies available<hr></th>
		</tr>
		<%
			Connection conn = null;
			Statement st = null;
			ResultSet rs= null;
			try{
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myreaderspace","root","MSSM1234");
				st = conn.createStatement();
				
				String qry="select * from book";
				rs=st.executeQuery(qry);
				
				while(rs.next()){
					out.println("<tr>");
					out.println("<td><label class='control control--radio'> <input type='radio' name='bookid' value="+rs.getString(1)+" /> <div class='control__indicator'></div></td>");
					out.println("<td> "+rs.getString(1)+"<hr></td>");
					out.println("<td> "+rs.getString(2)+"<hr></td>");
					out.println("<td> "+rs.getString(3)+"<hr></td>");
					out.println("<td> "+rs.getString(4)+"<hr></td>");
					out.println("<td> "+rs.getString(5)+"<hr></td>");
					out.println("<td> "+rs.getString(6)+"<hr></td>");
					out.println("</tr>");
				}
			}catch(Exception e){}
		%>
		</table>
		<br /><br /><input type='submit' name='m_request' value='Update' />
		</form>
		<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script tpe="text/javascript">
		var status = document.getElementById("status").value;
		if(status == "failed"){
			swal("Sorry","There was a problem","error");
		} else if(status == "success"){
			swal("Success!!","Details updated successfully","success");
		}
	</script>
</body>
</html>