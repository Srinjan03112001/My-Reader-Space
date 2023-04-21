<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,700">
		<link rel="stylesheet" type="text/css" href="member/css/header_member_style.css" />
		

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
					<a href="member_my_books.jsp">My books</a>
					<a href="logout">Logout</a>
				</div>
			</div>
		</header>
</body>
</html>