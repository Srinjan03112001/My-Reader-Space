<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My books</title>
<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,700">
		<link rel="stylesheet" type="text/css" href="member/css/header_member_style.css" />
		<link rel="stylesheet" type="text/css" href="css/global_styles.css">
		<link rel="stylesheet" type="text/css" href="css/custom_checkbox_style.css">
		<link rel="stylesheet" type="text/css" href="member/css/my_books_style.css">
</head>
<body>
<header>
			<div id="cd-logo">
				<a href="../">
					<img src="member/img/ic_logo.svg" alt="Logo" />
					<p>MyReaderSpace</p>
				</a>
			</div>
			
			<div class="dropdown">
				<button class="dropbtn">
					<p id="librarian-name"><%= session.getAttribute("name") %></p>
				</button>
				<div class="dropdown-content">
					<a href="member_home.jsp">Home</a>
					<a href="logout">Logout</a>
				</div>
			</div>
		</header>
	<%
Connection conn = null;
Statement st = null;
ResultSet rs1, rs2= null;
try{
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myreaderspace","root","MSSM1234");
	st = conn.createStatement();
	String name = (String) session.getAttribute("name");
	
	PreparedStatement pst1 = conn.prepareStatement("select issue_id, bookid, due_date, last_reminded from book_issue_log where member = ?");
	pst1.setString(1,name);
	rs1=pst1.executeQuery();
	
	PreparedStatement pst2 = conn.prepareStatement("select title from book where bookid = ?");
	
		%>
		<input type="hidden" id="status" value="<%= request.getAttribute("status")%>">
		<form class='cd-form' method='POST' action='return'>
		<legend>My Books</legend>
		<div class='error-message' id='error-message'>
				<p id='error'></p>
			</div>
			<table width='100%' cellpadding=10 cellspacing=10>
				<tr>
					<th></th>
					<th>Issue ID<hr></th>
					<th>Book ID<hr></th>
					<th>Title<hr></th>
					<th>Due Date<hr></th>
					<th>Reminded<hr></th>
				</tr>
	<%
		int i=0;
		while(rs1.next()){
			i++;
			pst2.setString(1, rs1.getString(2));
			rs2 = pst2.executeQuery();
			rs2.next();
			out.println("<tr>");
			out.println("<td><label class='control control--checkbox'><input type='checkbox' name='bookids' value='"+rs1.getString(2)+"' /><div class='control__indicator'></div></label></td>");
			out.println("<td> "+rs1.getString(1)+"<hr></td>");
			out.println("<td> "+rs1.getString(2)+"<hr></td>");
			out.println("<td> "+rs2.getString(1)+"<hr></td>");
			out.println("<td> "+rs1.getString(3)+"<hr></td>");
			out.println("<td> "+rs1.getString(4)+"<hr></td>");
			out.println("</tr>");
		}
		
		if(i==0){
			out.println("<h2 align='center'>No Books Issued</h2>");
		}else{
			%>
			</table><br />
			<input type='submit' name='b_return' value='Return selected books' />
			</form>
			<%
		}
	}catch(Exception e){ out.println(e);}
			%>
			
			<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script tpe="text/javascript">
		var status = document.getElementById("status").value;
		if(status == "failed"){
			swal("Sorry","There was a problem","error");
		} else if(status == "success"){
			swal("Success!!","Books returned successfully","success");
		}
	</script>
</body>
</html>