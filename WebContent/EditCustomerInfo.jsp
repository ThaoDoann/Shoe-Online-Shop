<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import = "javax.servlet.http.*, Model.Customer"  %>
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
  	Customer customerToEdit = (Customer)session.getAttribute("customerToEdit");
  	
  	
  %>
 
  
  
  

  <div class="container" >
    <div class="jumbotron">
      <form class="form-signin" action="CustomerController" Method= "POST">
        <h2 class="form-signin-heading"><span class="glyphicon glyphicon-edit"></span>&nbsp;&nbsp;Account Information

        </h2><br>
        <% 
	          System.out.println("session.getAttribute(\"InfoEditted\"): "+session.getAttribute("InfoEditted"));
	          if (session.getAttribute("InfoEditted") != null) {
	        	  System.out.println("AccountInfo.jsp > first if");	
	        	  boolean InfoEditted = (boolean)session.getAttribute("InfoEditted");       			
            	  System.out.println("LogInForm.jsp > second if");	
  			  	  out.println("<h5 style = 'color: blue'>Your account information has changed!</h5>");
		  			
	          } 
	          else {
	  			  System.out.println("AccountInfo.jsp > second else");
	  			  out.println("<h5>You can edit your information here. Please add new information and click save button.</h5>"); 
	  		  	}
		  %>
        
        <!-- username -->
        <div class="input-group" style="margin-bottom:6px;">
          <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
          <input type="text" class="form-control" name="regUserName" value="<%=customerToEdit.getCxUserName()%>" id="userName" readonly >          
        </div>
        <!-- password -->
        <div class="input-group" style="margin-bottom:6px">
          <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
          <input type="password" class="form-control" name="regPassword" value="<%=customerToEdit.getCxPassword()%>" onchange="btnAble()" required><br>
        </div>
        <!-- first name -->
        <div class="input-group" style="margin-bottom:6px; width:49.5%; float:left">
          <span class="input-group-addon"><i class="glyphicon glyphicon-text-background"></i></span>
          <input type="text" class="form-control" name="regFirstName" value="<%=customerToEdit.getCxFirstName()%>" onchange="btnAble()" required>
        </div>
        <!-- last name -->
        <div class="input-group" style="margin-bottom:6px; width:49.5%; float:right">
          <span class="input-group-addon"><i class="glyphicon glyphicon-text-background"></i></span>
          <input type="text" class="form-control" name="regLastName" value="<%=customerToEdit.getCxLastName()%>" onchange="btnAble()" required><br>
        </div>
        <!-- address -->
        <div class="input-group" style="margin-bottom:6px">
          <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
          <input type="text" class="form-control" name="regAddress" value="<%=customerToEdit.getCxAddress()%>" onchange="btnAble()" required><br>
        </div>
        <!-- city -->
        <div class="input-group" style="margin-bottom:6px; width:49.5%; float:left">
          <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
          <input type="text" class="form-control" name="regCity" value="<%=customerToEdit.getCxCity()%>" onchange="btnAble()" required><br>
        </div>
        <!-- postal code -->
        <div class="input-group" style="margin-bottom:6px; width:49.5%; float:right">
          <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
          <input type="text" class="form-control" name="regPostalCode" value="<%=customerToEdit.getCxPostalCode()%>" onchange="btnAble()" required><br>
        </div>
        <br><br><br><br>
          <button class="btn btn-lg btn-primary btn-block" type="submit" name="action" value = "EditCustomerInfo" id="EditBtn" onchange="myFunction()" disabled >SAVE CHANGES</button>
        
        <br><br>
        
        
        
      </form>
    </div>
    <br><br>
  </div>

<script>
	function btnAble() {
		document.getElementById("EditBtn").disabled = false;
	}
</script>
	
<%@ include file="Footer.jsp" %>
