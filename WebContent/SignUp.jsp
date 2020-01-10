<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"     
    %>
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
  </nav>


 
	
  <div class="container" >
    <div class="jumbotron">
      <form class="form-signin" action="CustomerController" Method= "POST">
        <h2 class="form-signin-heading"><span class="glyphicon glyphicon-edit"></span>&nbsp;&nbsp;Customer Registration</h2><br>
        <h5>Please fill in this form to create an account.</h5>
        <!-- username -->
        <div class="input-group" style="margin-bottom:6px;">
          <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
          <input type="text" class="form-control" name="regUserName" placeholder="User Name" style="width: 80%" id="userName" required >
          <button class="btn btn-sm btn-default" id="validationBtn" value = "UsernameCheckBtn" name="action" type="button" style="float:right; width:19%; height:34px" onclick="checkUsernameValidation()">CHECK VALIDATION</button>
        </div>
        <!-- password -->
        <div class="input-group" style="margin-bottom:6px">
          <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
          <input type="password" class="form-control" name="regPassword" placeholder="Password" required><br>
        </div>
        <!-- first name -->
        <div class="input-group" style="margin-bottom:6px; width:49.5%; float:left">
          <span class="input-group-addon"><i class="glyphicon glyphicon-text-background"></i></span>
          <input type="text" class="form-control" name="regFirstName" placeholder="First Name" required>
        </div>
        <!-- last name -->
        <div class="input-group" style="margin-bottom:6px; width:49.5%; float:right">
          <span class="input-group-addon"><i class="glyphicon glyphicon-text-background"></i></span>
          <input type="text" class="form-control" name="regLastName" placeholder="Last Name"" ><br>
        </div>
        <!-- address -->
        <div class="input-group" style="margin-bottom:6px">
          <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
          <input type="text" class="form-control" name="regAddress" placeholder="Address" required><br>
        </div>
        <!-- city -->
        <div class="input-group" style="margin-bottom:6px; width:49.5%; float:left">
          <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
          <input type="text" class="form-control" name="regCity" placeholder="City" required><br>
        </div>
        <!-- postal code -->
        <div class="input-group" style="margin-bottom:6px; width:49.5%; float:right">
          <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
          <input type="text" class="form-control" name="regPostalCode" placeholder="Postal Code" required><br>
        </div>
        <br><br><br><br>
        <div style="text-align:center">
          By creating an account you agree to our <a href="https://policies.google.com/terms?hl=en&gl=ZZ">Terms & Privacy</a>.<br><br>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit" name="action" value = "SignUp" id="signupBtn" disabled>SIGN UP</button>
        <div style="text-align:center">
          Already have an account? <a href="LogIn.jsp"> Click here to sign in!</a>
        </div>

        <br><br>
      </form>
    </div>
    <br><br>
  </div>
<script>
	
  var validationButton = document.getElementById("validationBtn");
  function checkUsernameValidation () {
    if (true) {
      validationButton.innerHTML="Validated";
      validationButton.style.color="green"
      document.getElementById("signupBtn").disabled = false;
      
    }
    else {
      validationButton.innerHTML="Invalidated. Try Again";
      validationButton.style.color="red"
    }
  }
</script>
<%@ include file="Footer.jsp" %>



