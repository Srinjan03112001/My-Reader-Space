<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="css/global_styles.css">
		<link rel="stylesheet" type="text/css" href="css/form_styles.css">
		<link rel="stylesheet" type="text/css" href="member/css/index_style.css">
<title>Member Login</title>
</head>
<body>

<input type="hidden" id="status" value="<%= request.getAttribute("status")%>">
	<form class="cd-form" method="POST" action="memberLogin">
		
			<legend>Member Login</legend>
			
			<div class="error-message" id="error-message">
				<p id="error"></p>
			</div>
			
			<div class="icon">
				<input class="m-user" type="text" name="m_user" placeholder="Username" required />
			</div>
			
			<div class="icon">
				<input class="m-pass" type="password" name="m_pass" placeholder="Password" required />
			</div>
			
			<input type="submit" value="Login" name="m_login" />
			
			<br /><br /><br /><br />
			
			<p align="center">Don't have an account?&nbsp;<a href="member_register.jsp">Sign up</a>
		</form>
		
		<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script tpe="text/javascript">
		var status = document.getElementById("status").value;
		if(status == "failed"){
			swal("Sorry","Wrong Username or Password","error");
		}else if(status == "registered"){
			swal("Success","Registered Successfully","success");
		}
	</script>
</body>
</html>