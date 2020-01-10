<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
     import  = "java.sql.*, Controller.ConnectionFactory, java.util.*, Model.Order, Model.Shoe" %>
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
  %>
  
<%
	//get the product id of the first checked checkbox
	int itemId = Integer.parseInt(request.getParameter("product"));
	System.out.println(itemId);
	//get the selected shoe information
	Shoe shoe = new Shoe();
    Shoe itemOrdered = shoe.getShoe(itemId);
    
    //the category of the shoe
    String category = itemOrdered.getCategory();
%>

<form action = "ProductController" method ="POST">
  <div class="container" >
    <div class="jumbotron">
        <h2 class="form-signin-heading"><span class="glyphicon glyphicon-pencil">  </span>   Edit Item</h2><br>
        <h5>Edit the shoe information.</h5>
        <!-- itemId -->
        <div class="input-group" style="margin-bottom:6px">
          <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
          <input type="text"  name="editItemId" class="form-control"  value="<%=itemOrdered.getItemId() %>" readonly><br>
        </div>
        <!-- itemName -->
        <div class="input-group" style="margin-bottom:6px">
          <span class="input-group-addon"><i class="glyphicon glyphicon-text-background"></i></span>
          <input type="text"  name="editItemName" class="form-control"  value="<%=itemOrdered.getItemName() %>" required><br>
        </div>
        <!-- category -->
        <div class="input-group" style="margin-bottom:6px">
          <span class="input-group-addon"><i class="	glyphicon glyphicon-glass"></i></span>
		  <select id="editCategory" name = "editCategory"  class="form-control"  style="width:100%; height:30px;font-size:12px;margin:auto">
                <% if(category.equals("Kid")){ %>
                    	<option value='Kid' selected>Kid</option>
                <% }else {%>
                    	<option value='Kid'>Kid</option>
                <%} if(category.equals("Women")){ %>
                    	<option value = "Women" selected>Women</option>
               <% }else {%>
                    	<option value = "Women">Women</option>
                <%} if(category.equals("Men")){ %>
                    	<option value = "Men" selected>Men</option>
                <% }else {%>
                    	<option value = "Men">Men</option>
                <%}%>
           </select>
		  <br>
        </div>
        <!-- size -->
        <div class="input-group" style="margin-bottom:6px; width:33%; float:left">
          <span class="input-group-addon"><i class="	glyphicon glyphicon-resize-full"></i></span>
          <input type="number"  name="editItemSize" class="form-control" value="<%=itemOrdered.getShoeSize() %>" required>
        </div>
        <!-- price -->
        <div class="input-group" style="margin-bottom:6px; width:33%; float:right">
          <span class="input-group-addon"><i class="glyphicon glyphicon-text-background"></i></span>
          <input type="number"  name="editPrice" class="form-control" min="0" step=0.01  value="<%=itemOrdered.getPrice() %>" required><br>
        </div>
        <!-- quantity -->
        <div class="input-group" style="margin-bottom:6px; width:33%;">
          <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
          <input type="number"  name="editQty" class="form-control" value="<%=itemOrdered.getQuantity() %>" required><br>
        </div>
        <!-- description -->
        <div class="input-group" style="margin-bottom:6px;  float:left">
          <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
          <input type="text"  name="editDescription" class="form-control"  value="<%=itemOrdered.getDescription()%>" required><br>
          
  
        </div><br><br>
        
        <div class="panel-body" style="text-align:center;" >
        	<img id = "imageFile" src="<%=itemOrdered.getImage() %>" class="img-responsive"  style="height:180pt;margin:auto" alt="Image"  ><br>
        	<input  id ="myFile" style=" margin:auto" type="file" accept="image/png, image/jpeg" onchange="myFunction()"  onclick="myFunction()" name ="editImg" value = "<%=itemOrdered.getImage() %>" required>
        </div>
        
        <br><br>
         <div style="text-align:center;"> 
         	
         	<button class="btn btn-md btn-primary" type="submit" name="action" value="editProduct"  style="width:140px">EDIT PRODUCT</button>
         	<button class="btn btn-md btn-primary" type="button" onclick="window.location='CSR_Product.jsp'" style="width:140px">CANCEL</button>
        </div>
      
    </div>
  </div>

  </form>
<script>
function myFunction() {
        var x = document.getElementById("myFile").value;
        x = x.replace(/.*[\/\\]/, '');
        var category = document.getElementById("editCategory").value;

        document.getElementById("imageFile").src =  "images/"+category+"_Shoes/"+x;
     //   document.getElementById("myFile").setAttribute("value", (category+"/"+x));
       // document.getElementById("myFile").setAttribute("value", ("images/"+category+"_Shoes/"+x));
}
</script>


<%@ include file="Footer.jsp" %>
