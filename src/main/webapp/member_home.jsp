<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    	if(session.getAttribute("name")==null){
    		response.sendRedirect("member_login.jsp");
    	}
    %>
    <%@ include file = "member_header.jsp" %>
    <%@page import = "java.sql.*" %>
    <%! String search= null ;%>
    <%@ page import ="com.MyReaderSpace.registration.*" %>
    <%! String searchBarText(String srch){
    		if(srch == null){
    			srch="";
    			return "placeholder='Search by Title of the Book..'";
    		}else{
    			if(srch.equals(""))
    				return "placeholder='Search by Title of the Book..'";
    			else
    				return "value = '"+srch+"'";
    		}
    	}
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome</title>
		<link rel="stylesheet" type="text/css" href="css/global_styles.css">
		<link rel="stylesheet" type="text/css" href="member/css/home_style.css">
		<link rel="stylesheet" type="text/css" href="css/custom_radio_button_style.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>

.searchBar form.example{
	margin-left: 450px;
	margin-top:20px;
	margin-bottom:-50px;
}
.searchBar form.example input[type=text] {
  padding: 10px;
  font-size: 17px;
  border: 1px solid grey;
  float: left;
  width: 80%;
  background: #f1f1f1;
}

.searchBar form.example button {
  float: left;
  width: 5%;
  padding: 10px;
  background: #2196F3;
  color: white;
  font-size: 17px;
  border: 1px solid grey;
  border-left: none;
  cursor: pointer;
}

.searchBar form.example button:hover {
  background: #0b7dda;
}

.searchBar form.example::after {
  content: "";
  clear: both;
  display: table;
}
</style>
</head>
<body>
<% search = request.getParameter("search"); %>
<input type="hidden" id="status" value="<%= request.getAttribute("status")%>">
		
		<div class='searchBar'>
			<form class="example" method="POST" action="member_home.jsp">
		
  				<input type="text" <%= searchBarText(search) %> name="search" style="margin:auto;max-width:500px">
  				<button type="submit"><i class="fa fa-search"></i></button>
			</form>
		</div>
		<form class='cd-form' method='POST' action='BookReq'>
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
			SearchTitle obj = new SearchTitle();
			Connection conn = null;
			Statement st = null;
			ResultSet rs= null;
			int i=0;
			try{
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myreaderspace","root","MSSM1234");
				st = conn.createStatement();
				
				String qry="select * from book";
				PreparedStatement pst = conn.prepareStatement("select * from book where title=?");
				rs=st.executeQuery(qry);
				
				if(search == null){
					while(rs.next()){
						out.println("<tr>");
						out.println("<td><label class='control control--radio'> <input type='radio' name='rd_book' value="+rs.getString(1)+" /> <div class='control__indicator'></div></td>");
						out.println("<td> "+rs.getString(1)+"<hr></td>");
						out.println("<td> "+rs.getString(2)+"<hr></td>");
						out.println("<td> "+rs.getString(3)+"<hr></td>");
						out.println("<td> "+rs.getString(4)+"<hr></td>");
						out.println("<td> "+rs.getString(5)+"<hr></td>");
						out.println("<td> "+rs.getString(6)+"<hr></td>");
						out.println("</tr>");
					}
				}
				else{
					while(rs.next()){
						if(obj.searchText(search,rs.getString(2))){
							i++;
							out.println("<tr>");
							out.println("<td><label class='control control--radio'> <input type='radio' name='rd_book' value="+rs.getString(1)+" /> <div class='control__indicator'></div></td>");
							out.println("<td> "+rs.getString(1)+"<hr></td>");
							out.println("<td> "+rs.getString(2)+"<hr></td>");
							out.println("<td> "+rs.getString(3)+"<hr></td>");
							out.println("<td> "+rs.getString(4)+"<hr></td>");
							out.println("<td> "+rs.getString(5)+"<hr></td>");
							out.println("<td> "+rs.getString(6)+"<hr></td>");
							out.println("</tr>");
						}
						
					}
					
					if(i==0){
						out.println("<h2 align='center'> No Book Available with the said title </h2>");
					}
				}
				
			}catch(Exception e){}
		%>
		</table>
		<br /><br /><input type='submit' name='m_request' value='Request book' />
		</form>
		<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script tpe="text/javascript">
		var status = document.getElementById("status").value;
		if(status == "failed"){
			swal("Sorry","there was some problem","error");
		} else if(status == "book_present"){
			swal("Sorry","You cannot request an issued book","error");
		} else if(status == "success"){
			swal("Success!!","Your book has been requested","success");
		} else if(status =="no_more_books"){
			swal("Sorry","Can't issue more than 3 books at a time","error");
		}
	</script>
		</body>
</html>