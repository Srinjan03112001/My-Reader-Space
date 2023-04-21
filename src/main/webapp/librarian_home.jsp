<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    	if(session.getAttribute("lib_name")==null){
    		response.sendRedirect("librarian_login.jsp");
    	}
    %>
    <%@ include file = "librarian_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome</title>
<link rel="stylesheet" type="text/css" href="librarian/css/home_style.css" />
</head>
<body>

<div id="allTheThings">
			
			<a href="pending_book_requests.jsp">
				<input type="button" value="Pending book requests" />
			</a><br />
			<a href="insert_book.jsp">
				<input type="button" value="Add a new book" />
			</a><br />
			<a href="update_book_details.jsp">
				<input type="button" value="Update book details" />
			</a><br />
			<a href="update_balance.jsp">
				<input type="button" value="Update balance of a member" />
			</a><br />
			<a href="due_handler.jsp">
				<input type="button" value="Reminders for today" />
			</a><br /><br />
		</div>
</body>
</html>