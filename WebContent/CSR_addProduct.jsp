<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import ="Model.Shoe, Model.Customer" %>
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

<form action = "ProductController" method ="POST">
  <div class="container" >
    <div class="jumbotron">
        <h2 class="form-signin-heading"><span class="glyphicon glyphicon-pencil">    </span>   New Item</h2><br>
        <h5>Please fill the new shoe information.</h5>
        <!-- itemName -->
        <div class="input-group" style="margin-bottom:6px">
          <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
          <input type="text"  name="addItemName" class="form-control"  placeholder="Item Name" required><br>
        </div>
        <!-- category -->
        <div class="input-group" style="margin-bottom:6px">
          <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
          <select id="category" class="form-control"  name="addCategory" required>
			  <option value="" disabled >Category</option>
			  <option value="Kid">Kid</option>
			  <option value="Women">Women</option>
			  <option value="Men">Men</option>
		  </select><br>
        </div>
        <!-- size -->
        <div class="input-group" style="margin-bottom:6px; width:33%; float:left">
          <span class="input-group-addon"><i class="glyphicon glyphicon-text-background"></i></span>
          <input type="number" min= "0" max= "12" name="addItemSize" class="form-control" placeholder="Size" required>
        </div>
        <!-- price -->
        <div class="input-group" style="margin-bottom:6px; width:33%; float:right">
          <span class="input-group-addon"><i class="glyphicon glyphicon-text-background"></i></span>
          <input type="number"  name="addPrice" class="form-control" min="0" step=0.01  placeholder="Price" required><br>
        </div>
        <!-- quantity -->
        <div class="input-group" style="margin-bottom:6px; width:33%;">
          <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
          <input type="number"  name="addQty" min = "0" class="form-control" placeholder="Quantity" required><br>
        </div>
        <!-- description -->
        <div class="input-group" style="margin-bottom:6px;  float:left">
          <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
          <input type="text"  name="addDescription" class="form-control"  placeholder="Description" required><br>
  
        </div><br><br>
        <!--  Image -->
        <div class="panel-body" style="text-align:center;" >
        	<img id = "imageFile" src="images/No_Image/no-image.png" class="img-responsive" style="height:180pt;margin:auto" alt="Image" name ="addImage" ><br>
        	<input  id ="myFile" style=" margin:auto" type="file" accept="image/png, image/jpeg" name ="imagePath" value = "" onchange="myFunction()" required>
        </div>
        
        <br><br>
         <div style="text-align:center;"> 
         	
         	<button class="btn btn-md btn-primary" type="submit" name="action" value="addProduct"  style="width:140px">ADD</button>
         	<button class="btn btn-md btn-primary" type="button" onclick="window.location='CSR_Product.jsp'" style="width:140px">CANCEL</button>
        </div>
      
    </div>
  </div>

 </form>
 <br><br><br><br>
 
<script>
function myFunction() {
        var x = document.getElementById("myFile").value;
        x = x.replace(/.*[\/\\]/, '');
        var category = document.getElementById("category").value;

        document.getElementById("imageFile").src =  "images/"+category+"_Shoes/"+x;
     //   document.getElementById("myFile").setAttribute("value", (category+"/"+x));
        document.getElementById("myFile").setAttribute("value", ("images/"+category+"_Shoes/"+x));
}
</script>

<%@ include file="Footer.jsp" %>
