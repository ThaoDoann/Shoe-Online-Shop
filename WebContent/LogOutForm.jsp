<div class="container">
    <div class="jumbotron">
      <form class="form-signin" action="LogInController" METHOD = "POST">
      	<h2 class="form-signin-heading"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Do you really want to log out?</h2><br>
		<br><br><br><br>
		<div style="text-align:center">
			  <% if (session.getAttribute("isLoggedIn") != null) {	  
					  if (session.getAttribute("LogInType").equals("Customers")) { 
						  out.println ("<button class=\"btn btn-lg btn-primary btn-block\" formaction=\"Home.jsp\" style=\"width:49%;height:100%;display:inline-block;margin:auto\">STAY</button>");
					  }
					  else if (session.getAttribute("LogInType").equals("CSR")) { 
						  out.println ("<button class=\"btn btn-lg btn-primary btn-block\" formaction=\"CSR_Product.jsp\" style=\"width:49%;height:100%;display:inline-block;margin:auto\">STAY</button>");
					  }
				 }
			  %>
			<button class="btn btn-lg btn-primary btn-block" type="submit" name="action" value="SignOut" style="width:49%;height:100%;display:inline-block;margin:auto">LOG OUT</button>
        </div>
        <br>
     </form>
    </div>
    <br><br>
  </div>