<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import = "javax.servlet.http.*, Model.Customer, java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <%
  Customer customer = new Customer();
  ArrayList<Customer> customerList = customer.getCustomerList();
  int totalNumCustomer = 0;
  %>


  <div class="container">
    <div class="jumbotron">

      <h2><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Customer Information</h2>
      
      <!-- SEARCH BAR --> 
      <div style="margin-bottom:13px; margin-top:13px">     
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
      <form action="CustomerController" method="post" class="form-signin">
      <div class="well" style="background-color:white">
      	<!-- TABLE -->
        <table class="table table-hover" style="text-align:center">
          <thead>
            <tr>
              <th></th>
              <th style="text-align:center">Customer ID</th>
              <th style="text-align:center">First Name</th>
              <th style="text-align:center">Last Name</th>
              <th style="text-align:center">Address</th>
              <th style="text-align:center">City</th>
              <th style="text-align:center">Postal Code</th>
              <th style="text-align:center">User Name</th>
              <th style="text-align:center">Password</th>
            </tr>
          </thead>
          <tbody>
          
           <% 
          for(int i = 0; i < customerList.size(); i++  ){  
        	  
          
 		 %>
            
            <tr>
              <td>
                
                  <input type="checkbox" name="cxID" value = <%=customerList.get(i).getCxID() %> >
                </form>
              </td>
              <td><%=customerList.get(i).getCxID() %></td>
              <td><%=customerList.get(i).getCxFirstName() %></td>
              <td><%=customerList.get(i).getCxLastName()%></td>
              <td><%=customerList.get(i).getCxAddress()%></td>
              <td><%=customerList.get(i).getCxCity()%></td>
              <td><%=customerList.get(i).getCxPostalCode()%></td>
              <td><%=customerList.get(i).getCxUserName()%></td>
              <td><%=customerList.get(i).getCxPassword()%></td>
              
            </tr>
             <% 
          		}            
 			 %>
          </tbody>
        </table>    
        <hr style="border:solid 1px lightGray">
        <p style="text-align:right; margin-right:20px;font-size:16px;font-weight:bold">Total Number of Customers: <%= customerList.size() %></p>
      </div>
	  </form>		
      <div style="text-align:center;">
        <button style="width:80px" class="btn btn-md btn-primary" type="submit" name="action" value="EditFromList" >EDIT</button>&nbsp;&nbsp;
        <button style="width:80Px" class="btn btn-md btn-primary" type="submit" name="action" value="Delete">DELETE</button>
      </div>
       
    </div>
    <br><br>
  </div>

<%@ include file="Footer.jsp" %>
