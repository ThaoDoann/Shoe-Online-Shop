 
    <div class="container">
    <div class="jumbotron">
      <form class="form-signin" action="LogInController" METHOD = "POST">
        <h2 class="form-signin-heading"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Please log in</h2><br>
          <% 
	          System.out.println("session.getAttribute(\"logInFailed\"): "+session.getAttribute("logInFailed"));
	          if (session.getAttribute("logInFailed") != null) {
	        	  System.out.println("LogInForm.jsp > first if");	
	        	  boolean isLogInFailed = (boolean)session.getAttribute("logInFailed");
	            	if (isLogInFailed == true) {          			
	            	  System.out.println("LogInForm.jsp > second if");	
	  			  	  out.println("<h5 style = 'color: red'>Invalid username and password. Please try again!</h5>");
	  			  	}
		  			else {
		  			  System.out.println("LogInForm.jsp > secondelse");
		  			  out.println("<h5></h5>"); 
		  		  	}
	          }          
		  %>
        
        <input type="text" class="form-control" placeholder="Please enter your user name" name="regUserName"  style="height:50px;margin-bottom:10px" required>
        <input type="password" class="form-control" placeholder="Please enter your password" name="regPassword" style="height:50px;margin-bottom:10px" required>
        <div class="checkbox" style="text-align:center">
          <b>Log in as a</b>
          <input type="radio" name="userType" value="Customers"> Customer
          <input type="radio" name="userType" value="CSR"> CSR <br>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit" name="action" value="SignIn">LOG IN</button>
        <div style="text-align:center">
          Haven't gotten an account yet? <a href="SignUp.jsp"> Click here to create a new account!</a>
        </div>

        <br><br>
      </form>
    </div>
    <br><br>
  </div>