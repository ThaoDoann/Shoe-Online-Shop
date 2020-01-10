<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>THAM</title>
  <!-- https://www.getoutsideshoes.com/aigle-kids-woodypop-fun-unicorn-pink.html -->

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
    /* Remove the navbar's default rounded borders and increase the bottom margin */
    .navbar {
      margin-bottom: 50px;
      border-radius: 0;
    }

    /* Remove the jumbotron's default bottom margin */
     .jumbotron {
      margin-bottom: 0;
    }

    /* Add a gray background color and some padding to the footer */
    footer {
      background-color: #f2f2f2;
      padding: 25px;
    }
  </style>
</head>
<body>

  <div class="jumbotron">
    <div class="container text-center">
      <h1>THAM Shoes Shop</h1>
      <p>Mission, Vission & Values</p>
    </div>
  </div>
  <% if (session.getAttribute("isLoggedIn") != null) {	  
	  if (session.getAttribute("LogInType").equals("Customers")) { %>
	  	<%@ include file="nav_logedIn.jsp" %>
	  
		  <%
	  	}
	  else { %>
		  <%@ include file="nav_CSR.jsp" %> <%
	  	}
	  }
	 else { %>	  
	 <%@ include file="nav_logedOut.jsp" %><%  
  	 }
  %>

  <% if (session.getAttribute("isLoggedIn") == null) {%>	  	
	 	<%@ include file="LogInForm.jsp" %><%
  	}
	 else { %>
		 <%@ include file="LogOutForm.jsp" %> <%	 
  	 }
  %>

<%@ include file="Footer.jsp" %>