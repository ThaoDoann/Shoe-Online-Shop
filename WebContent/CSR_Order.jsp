<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import  = "Model.Customer, java.util.*, Model.Order, Model.Shoe" %>
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
      <p>Mission, Vision & Values</p>
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
      <div>
        <h2><span class="glyphicon glyphicon-gift"></span> Order Information</h2>
        <div style="margin-bottom:13px;margin-top:13px">
          <form>
            <div class="input-group">
              <input type="text" class="form-control" placeholder="Search">
              <div class="input-group-btn">
                <button class="btn btn-default" type="submit">
                  <i class="glyphicon glyphicon-search"></i>
                </button>
              </div>
            </div>
          </form>
        </div>
      </div>


<% 
	int totalOrder = 0;
	double netPrice =0;


%>
	 <form method ="POST" action = "ShoppingController">
      <div class="well" style="background-color:white">
        <table class="table table-hover" style="text-align:center">
          <thead>
            <tr>
            <!--    <th></th> -->
              <th style="text-align:center">Order ID</th>
              <th style="text-align:center">Order Date</th>
              <th style="text-align:center">Customer ID</th>
              <th style="text-align:center">Item ID</th>
              <th style="text-align:center">Quantity</th>
              <th style="text-align:center">Order Status</th>
            </tr>
          </thead>
          <tbody>
           <% 
        	Order order = new Order();
        	ArrayList<Order>orderList = order.getOderList();

            
         	for(int i =0; i < orderList.size(); i++  ){  
        	  	String status = orderList.get(i).getStatus();
        	 	 totalOrder += orderList.get(i).getQuantity();
 			%>           
            <tr>
           <!-- <td> <input type="checkbox" name="order" value = <%=orderList.get(i).getOrderId()%> ></td> -->
              <!-- OrderId -->
              <td><%=orderList.get(i).getOrderId() %></td>
              <!-- Order Date -->
              <td><%=orderList.get(i).getOrderDate()%> </td>	
              <!-- Customer ID -->
              <td><%=orderList.get(i).getCustomerId()%> </td>      		
              <!-- Item ID -->
              <td><%=orderList.get(i).getItemId()%> </td>
              <!-- Quantity -->
              <td><%=orderList.get(i).getQuantity()%> </td>
              <!-- Order Status -->
              <td>
                  <select name = "status"  class="form-control"  style="width:150px; height:30px;font-size:12px;margin:auto">
                    <% if(status.equals("Order-Place")){ %>
                    	<option value='Order-Place' selected>  Customer Ordered</option>
                    <% }else {%>
                    	<option value='Order-Place'>  Customer Ordered</option>
                    <%} if(status.equals("In-Process")){ %>
                    	<option value = "In-Process" selected> In Process</option>
                    <% }else {%>
                    	<option value = "In-Process"> In Process</option>
                    <%} if(status.equals("Delivered")){ %>
                    	<option value = "Delivered" selected>Delivered</option>
                    <% }else {%>
                    	<option value = "Delivered">Delivered</option>
                    <%} if(status.equals("Completed")){ %>
                   		<option value = "Completed" selected>Arrived</option>
                   	<% }else {%>
                   		<option value = "Completed">Arrived</option>
                   	<%}%>
                  </select>
              </td>
            </tr>
            <%}
          	order = null;%>

          </tbody>
        </table>
        <hr style="border:solid 1px lightGray">
        <p style="text-align:right; margin-right:20px;font-size:16px;font-weight:bold">Total Number of Order: <%=totalOrder%> <p>
      </div>

      <div style="text-align:center;">
        <button style="width:80px" class="btn btn-md btn-primary" type="submit" name= "action" value="editOrder">SAVE</button>
      </div>
      </form>
    </div>   
    <br><br>
  </div>
  
<%@ include file="Footer.jsp" %>
