<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Librarian Login</title>
		<link rel="stylesheet" type="text/css" href="css/global_styles.css">
		<link rel="stylesheet" type="text/css" href="css/form_styles.css">
		<link rel="stylesheet" type="text/css" href="librarian/css/index_style.css">
</head>
<body>
<input type="hidden" id="status" value="<%= request.getAttribute("status")%>">
	<form class="cd-form" method="POST" action="LibLogin">
		
		<legend>Librarian Login</legend>
		
			<div class="error-message" id="error-message">
				<p id="error"></p>
			</div>
			
			<div class="icon">
				<input class="l-user" type="text" name="l_user" placeholder="Username" required />
			</div>
			
			<div class="icon">
				<input class="l-pass" type="password" name="l_pass" placeholder="Password" required />
			</div>
			
			<input type="submit" value="Login" name="l_login"/>
			
		</form>
		<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script tpe="text/javascript">
		var status = document.getElementById("status").value;
		if(status == "failed"){
			swal("Sorry","Wrong Username or Password","error");
		}
	</script>
</body>
</html>