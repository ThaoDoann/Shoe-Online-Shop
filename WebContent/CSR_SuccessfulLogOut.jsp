 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import = "Model.Customer"%>
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
  	Customer existingCxLogIn = (Customer)session.getAttribute("CxLogIn");
  	
  	
  %>

  <div class="container">
    <div class="jumbotron">
      <form class="form-signin" action="Controller" METHOD = "POST">
        <h2 class="form-signin-heading"><span class="glyphicon glyphicon-user"></span>ㅤPlease log in</h2>
        <div style="margin-bottom:10px;margin-top:10px">
          ㅤ
        </div>
        <input type="text" class="form-control" placeholder="Please enter your user name" name="userName"  style="height:50px;margin-bottom:10px;" required>
        <input type="password" class="form-control" placeholder="Please enter your password" name="password" style="height:50px;margin-bottom:10px" required>
        <div class="checkbox" style="text-align:center">
          <b>Log in as aㅤㅤ</b>
          <input type="radio" name="userType" value="Customers"> Customer ㅤㅤ
          <input type="radio" name="userType" value="CSR"> CSR <br>
        </div>
        <button class="btn btn-lg btn-primary btn-block  " type="submit" name="action" value = "SignIn">LOG IN</button>
        <div style="text-align:center">
          Haven't gotten an account yet? <a href="SignUp.jsp"> Click here to create a new account!</a>
        </div>

        <br><br>
      </form>
    </div>
    <br><br>
  </div>




<%@ include file="Footer.jsp" %>

