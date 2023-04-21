<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file = "librarian_header_2.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add book</title>
		<link rel="stylesheet" type="text/css" href="css/global_styles.css" />
		<link rel="stylesheet" type="text/css" href="css/form_styles.css" />
		<link rel="stylesheet" href="librarian/css/insert_book_style.css">
</head>
<body>
<input type="hidden" id="status" value="<%= request.getAttribute("status")%>">
	<form class="cd-form" method="POST" action="add">
			<legend>Enter book details</legend>
			
				<div class="error-message" id="error-message">
					<p id="error"></p>
				</div>
				
				
				<div class="icon">
					<input class="b-title" type="text" name="b_title" placeholder="Title" required />
				</div>
				
				<div class="icon">
					<input class="b-author" type="text" name="b_author" placeholder="Author" required />
				</div>
				
				<div>
				<h4>Category</h4>
				
					<p class="cd-select icon">
						<select class="b-category" name="b_category">
							<option>Fiction</option>
							<option>Non-fiction</option>
							<option>Education</option>
						</select>
					</p>
				</div>
				
				<div class="icon">
					<input class="b-price" type="number" name="b_price" placeholder="Price" required />
				</div>
				
				<div class="icon">
					<input class="b-copies" type="number" name="b_copies" placeholder="Copies" required />
				</div>
				
				<br />
				<input class="b-isbn" type="submit" name="b_add" value="Add book" />
		</form>
		
		<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script tpe="text/javascript">
		var status = document.getElementById("status").value;
		if(status == "failed"){
			swal("Sorry","The Book was not added","error");
		} else if(status == "book_present"){
			swal("Sorry","The Book is already present","error");
		} else if(status == "success"){
			swal("Success!!","The book has been added successfully","success");
		}
	</script>
</body>
</html>