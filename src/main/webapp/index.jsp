<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Reader Space</title>
<link rel="stylesheet" type="text/css" href="css/index_style.css" />
</head>
<body>
<%@ include file= "header.html" %>
	<div id="allTheThings">
			<div id="member">
				<a href="member_home.jsp">
					<img src="img/ic_member.svg" width="250px" height="auto"/><br />
					&nbsp;Member
				</a>
			</div>
			<div id="verticalLine">
				<div id="librarian">
					<a id="librarian-link" href="librarian_home.jsp">
						<img src="img/ic_librarian.svg" width="250px" height="auto" /><br />
						&nbsp;&nbsp;&nbsp;Librarian
					</a>
				</div>
			</div>
		</div>
</body>
</html>