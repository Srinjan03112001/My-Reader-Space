<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Member Register</title>
		<link rel="stylesheet" type="text/css" href="css/global_styles.css">
		<link rel="stylesheet" type="text/css" href="css/form_styles.css">
		<link rel="stylesheet" href="member/css/register_style.css">
</head>
<body>
<input type="hidden" id="status" value="<%= request.getAttribute("status")%>">
	<form class="cd-form" method="POST" action="memberRegister">
			<legend>Enter your details</legend>
			
				<div class="error-message" id="error-message">
					<p id="error"></p>
				</div>
				
				<div class="icon">
					<input class="m-user" type="text" name="m_user" id="m_user" placeholder="Username" required />
				</div>
				
				<div class="icon">
					<input class="m-pass" type="password" name="m_pass" placeholder="Password" required />
				</div>
				
				<div class="icon">
					<input class="m-name" type="text" name="m_name" placeholder="Full Name" required />
				</div>
				
				<div class="icon">
					<input class="m-email" type="email" name="m_email" id="m_email" placeholder="Email" required />
				</div>
				
				<div class="icon">
					<input class="m-balance" type="number" name="m_balance" id="m_balance" placeholder="Initial Balance" required />
				</div>
				
				<br />
				<input type="submit" name="m_register" value="Register" />
		</form>
		<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script tpe="text/javascript">
		var status = document.getElementById("status").value;
		if(status == "failed"){
			swal("Sorry","User details already exists","error");
		}
	</script>
</body>
</html>