
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" 
    import  = "java.sql.*, Controller.ConnectionFactory, java.util.*, Model.Shoe, Model.Customer" %>
    
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>THAM</title>
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


 <% 
        	Shoe order = new Shoe();
        	ArrayList<Shoe> kidShoeList = order.showShoeList("Kid");
        	request.setAttribute("kidShoeList", kidShoeList);
 %> 
 
 
	<div class="container"  >
	<%for(int i=0; i< kidShoeList.size(); i++){  %>
	  <form method = "POST" action ="ShoppingController">
		<div class="col-sm-4">
	        <div class="panel panel-default">
	          <div class="panel-heading" style="text-align:center;font-weight: bold"><%=kidShoeList.get(i).getItemName() %></div>
	          <div class="panel-body"><img src="<%=kidShoeList.get(i).getImage() %>" class="img-responsive" style="height:180pt;margin:auto" alt="Image"></div>
	          	<div class="panel-footer">
		          	<!-- Description -->
		            <div class = "itemDescription"> <%=kidShoeList.get(i).getDescription() %> </div>
		          	<!-- Price -->
		            Price <b>$<%=kidShoeList.get(i).getPrice() %></b><br><br>
		            <!-- Shoe size -->
		            <div style ="text-align: center">
		            	<select class="form-control" name = "KidShoeSize" style="max-width: 100px; height:34px; float:left" required>
							 <% 
							 int shoeSize = kidShoeList.get(i).getShoeSize();
							 for( int a =1; a <= 12; a++) { %>
		                  		<option value="<%=a %>" <% if(shoeSize == a) {%> selected <% } else {%>  hidden = true  <%};%> ><%=a%>  </option>
		                  	<%} %>
		 				</select> 
					
					 <!--  Quantity -->
	              	 <input type="number"  class="form-control" min="1" max = <%=kidShoeList.get(i).getQuantity() %> style="max-width: 100px; height:34px; float:left" 
	              	 placeholder = "Quantity" name = "quantity" required>
	              	 
	                 <button type="submit" name="action" value = "<%=kidShoeList.get(i).getItemId()%>" class="btn btn-default" style="margin-left:10px" >Add to Cart</button>
	            	</div>
	          	</div>
	       	</div>
      	</div>
      </form>
    <%} %>
</div>
 <br><br><br><br> 
  

<%@ include file="Footer.jsp" %>
