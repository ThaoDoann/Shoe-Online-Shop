<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import = "javax.servlet.http.*, Model.Customer, Model.Employee"   %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>THAM</title>
  
  <%-- String name = (String)session.getAttribute("fullName"); --%>
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

  

  <div class="container">
    <div class="jumbotron">
      <form class="form-signin" action="Controller" METHOD = "POST">
      	<% if (session.getAttribute("LogInType").equals("Customers")) {
      			Customer welcomeCx = (Customer)session.getAttribute("CxLogIn");
      			out.println("<h2 class='form-signin-heading'><span class='glyphicon glyphicon-ok'></span> Welcome! <b>");%>
      			<%=welcomeCx.getCxLastName()%>, <%=welcomeCx.getCxFirstName()%><%
      		}
      		else if (session.getAttribute("LogInType").equals("CSR")) {
      			Employee welcomeEmpl = (Employee)session.getAttribute("EmplLogIn");
      			out.println("<h2 class='form-signin-heading'><span class='glyphicon glyphicon-ok'></span> Welcome! <b>");%>
      			<%=welcomeEmpl.getEmplLastName()%>, <%=welcomeEmpl.getEmplFirstName()%><%
	  		}
      	%>
		
		
	
		
		
		
		.</b></h2>		
        <div style="color:green;margin-bottom:10px;margin-top:10px">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You have successfully logged in!
        </div>
     </form>
    </div>
    <br><br>
  </div>




<%@ include file="Footer.jsp" %>
