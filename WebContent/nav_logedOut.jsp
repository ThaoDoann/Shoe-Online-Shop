 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" 
    import  = "Model.Order, java.util.*, Model.Shoe, Model.Customer" %>
  <nav class="navbar navbar-inverse">
    <div class="container-fluid">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
      </div>
      <div class="collapse navbar-collapse" id="myNavbar">
        <ul class="nav navbar-nav">
          <li><a href="Home.jsp">Home</a></li>
          <li><a href="Women_Shoes.jsp">Women Shoes</a></li>
          <li><a href="Men_Shoes.jsp">Men Shoes</a></li>

          <li><a href="Kid_Shoes.jsp">Kids Shoes</a></li>
          <li><a href="Contact.jsp">Contact</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li><a href="SignUp.jsp"><span class="glyphicon glyphicon-edit"></span> Sign Up</a></li>
          <li><a href="LogIn.jsp"><span class="glyphicon glyphicon-user"></span> Log In</a></li>
          <li><a href="Cart.jsp"><span class="glyphicon glyphicon-shopping-cart"></span> Cart <span class="badge">
			<% Customer existingCxLogIn = (Customer)session.getAttribute("CxLogIn");
             if(existingCxLogIn != null){ 
				Order order = new Order();
				ArrayList<Order> customerCart = order.getCustomerCart(existingCxLogIn.getCxID());
             %>
             	<%=customerCart.size()%>
             <%} %>
			</span></a></li>
        </ul>
      </div>
    </div>
  </nav>