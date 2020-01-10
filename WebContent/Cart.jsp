<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import  = "Model.Customer, Controller.ConnectionFactory, java.util.*, Model.Order, Model.Shoe" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
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
  	Customer existingCxLogIn = (Customer)session.getAttribute("CxLogIn");
  %>


<%
	//get the orders of a specific user
	Order order = new Order();
	System.out.println(existingCxLogIn);
	if(existingCxLogIn != null){
		ArrayList<Order> customerCart = order.getCustomerCart(existingCxLogIn.getCxID());
		double netPrice = 0;
%>
 
 <form method ="POST" action = "ShoppingController" onsubmit="enable()">
  <div class="container">
    <div class="jumbotron">
      <h2><span class="glyphicon glyphicon-shopping-cart"></span>   My Shopping Cart</h2>
      <div class="well" style="background-color:white">
        <table class="table table-hover" style="text-align:center">
          <thead>
            <tr>
              <th></th>
              <th style="text-align:center">Name</th>
              <th style="text-align:center">Category</th>
              <th style="text-align:center">Size</th>
              <th style="text-align:center">Unit Price</th>
              <th style="text-align:center">Quantity</th>
              <th style="text-align:center">Tax</th>
              <th style="text-align:center">Total Price</th>
              <th style="text-align:center">Order Status</th>
            </tr>
          </thead>
          <tbody>
         <% 
          for(int i = 0; i < customerCart.size(); i++  ){  
        	  //this is the item that has been ordered
        	  Shoe shoe = new Shoe();
        	  Shoe itemOrdered = shoe.getShoe(customerCart.get(i).getItemId());
        	  
        	  //the total price and the net Price calculation
        	  double totalPrice = customerCart.get(i).getQuantity() * itemOrdered.getPrice() *(1-0.13);
	          netPrice += totalPrice;
	    
	          // the status of each ordered item
	          String cartStatus = customerCart.get(i).getStatus();
	          
	          // check if the user is allowed to edit the order information
	          boolean canEdit = true;
	          if(cartStatus.equals("Delivered") || cartStatus.equals("Completed") || cartStatus.equals("In-Process")){
	        	  canEdit = false;
	          }
 		 %>
        	  <tr>

              <td>
              		<!-- User can not change any order information except the order status is "Order Placed" -->
                  <input type="checkbox" name = "order" value = <%=customerCart.get(i).getOrderId()%>
                  <% if(canEdit == false) {%> disabled <%}; %>>
              </td>
              <!-- Item Name -->
              <td><%=itemOrdered.getItemName()%></td>
              <!-- category -->
              <td><%=itemOrdered.getCategory()%></td>
              <!-- Shoe size -->
              <td>
                  <select class="form-control" name = "shoeSize" style="width:80px; height:27px;font-size:13px;margin:auto"  >
                  	<% for( int a =1; a <= 12; a++) {
	                  	if(canEdit) { %>
	                  		<option value="<%=a %>" 
							<% if(itemOrdered.getShoeSize()==a) {%> selected <%};%> ><%=a%>  </option>
	                  	<% }else{ %>
	                  		<option value="<%=a %>" 
							<% if(itemOrdered.getShoeSize()==a) {%> selected 
							<% } else {%>  hidden = true  <%};%> ><%=a%>  </option>
	                  	<%} %>
					
					<% } %>
				  </select>
              </td>
              <!-- product price -->
              <td>$<%=itemOrdered.getPrice()%></td>
              <!-- order quantity -->
              <td>
                  <input type="number" name = "cartQty" class="form-control" min="1" max=  <%=itemOrdered.getQuantity() %>  onclick="enable()"
                  value= <%=customerCart.get(i).getQuantity()%>  style="width:80px; height:25px;margin:auto" <% if(canEdit == false) {%> readonly <%};%>>
              </td>         
              <td>13%</td>
              <!-- Total Price -->
              <td> <%=String.format ("$%.2f",totalPrice) %></td>

              <!-- Cart status -->
              <td>
                  <input type="text" name = "status" class="form-control"  
                  value= <%=cartStatus%>  style="width:150px; height:30px;font-size:12px;margin:auto" readonly>
              </td> 
            
   
            </tr>
        		
         <%  } order = null;  %>
   
          
          </tbody>
        </table>
        <hr style="border:solid 1px lightGray">
        <p style="text-align:right; margin-right:20px;font-size:16px;font-weight:bold">Net Price: $<%=String.format("%.2f",netPrice)%></p>
      </div>
     
      
      
      <div style="text-align:center;">
      	<button style="width:140px" class="btn btn-md btn-primary" type="submit" name = "action" value = "deleteCart">DELETE</button>
      	<button style="width:140px" class="btn btn-md btn-primary" type="submit" name = "action" value = "editCart"  >SAVE CHANGES</button>
  <!--  <button style="width:140Px" class="btn btn-md btn-primary" type="submit" name = "action" value = "payCart"   >CHECK OUT</button>  -->
      </div>
    </div>
    <br><br>
  </div>
  </form>
   <% } %>

<script>
	function enable() {
	    document.getElementsByClassName("form-control").disabled=false;
	}
</script>

<%@ include file="Footer.jsp" %>
    