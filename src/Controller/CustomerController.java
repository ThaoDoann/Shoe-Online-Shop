package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Customer;
/**
 * Servlet implementation class CustomerController
 */
@WebServlet("/CustomerController")
public class CustomerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static HttpSession session ;	
	static Connection con = null;
	static ResultSet rs = null;
	PreparedStatement pst;
	
	Statement st;
	
	
    public CustomerController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			System.out.println("CustomerController.jsp > doGet()");
			session = request.getSession();			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();			
			String action = request.getParameter("action");
			System.out.println("action: "+ action);
			
			if ("SignUp".equals(action)) {
				System.out.println("CustomerController.jsp > doGet() > SignUp Clicked");
				registration (request, response);				
			}
//			if ("UsernameCheckBtn".equals("action")) {
//				System.out.println("username checker btn clicked!");
//				usernameCheck (request, response);
//				
//			}
			
			if ("Edit".equals(action) ||  "EditCustomerInfo".equals(action)) {
				System.out.println("CustomerController.jsp > doGet() > AccountInfo Save Changes Btn Clicked");
				editCustomer (request, response, action);					
			}
			if ("EditFromList".equals(action)) {
				System.out.println("CustomerController.jsp > doGet() > EditFromList Clicked");
				editFromList (request, response);				
			}
			if ("Delete".equals(action)) {
				System.out.println("CustomerController.jsp > doGet() > EditFromList Clicked");
				deleteFromList (request, response);				
			}
			
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	public void editFromList (HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			System.out.println("CustomerController.jsp > editFromList()");
			String cxID[] = request.getParameterValues("cxID");
			
			if(cxID.length != 1) {
				System.out.println("CustomerController.jsp > editFromList() > if statement when 2 or more selected");
				session.setAttribute("EditFromListError", true);
			} else {
				//get customer info based on the customer Id
				int customerId = Integer.parseInt(cxID[0]);
				Customer a = new Customer();
				Customer customer = a.getCustomerInfo(customerId);
				
				session.setAttribute("customerToEdit", customer);
				 
				RequestDispatcher rd = request.getRequestDispatcher("EditCustomerInfo.jsp");
				rd.forward(request, response);				
			}				
		}
		catch (Exception e) {			
		}
	}
	
	public void deleteFromList (HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			System.out.println("CustomerController.jsp > deleteFromList()");
			String cxID[] = request.getParameterValues("cxID");
			con = ConnectionFactory.getConnection();
			
			for(int i=0; i< cxID.length; i++ ) {
				int customerId = Integer.parseInt(cxID[i]);
				String deleteCustomerQuery = "DELETE FROM Customers WHERE customerID = ? AND customerId NOT IN "
						+ "(select customerId from Orders )";
				pst = con.prepareStatement(deleteCustomerQuery);
				pst.setInt(1, customerId);
				
				System.out.println(i+ ". pst query: " + pst); 
				pst.executeUpdate();
				
				System.out.println("deleteCustomerQuery: " + deleteCustomerQuery);
			}
			
			RequestDispatcher rd = request.getRequestDispatcher("CSR_Customer.jsp");
			rd.forward(request, response);
			
			
		}
		catch (Exception e) {
			
		}
	}
	
	public void editCustomer(HttpServletRequest request, HttpServletResponse response, String action) throws Exception {
		try {
			System.out.println("CustomerController.jsp > editCustomer()");
			System.out.println("Session, userName : "+session.getAttribute("userName"));
			String customerUserName = request.getParameter("regUserName");
			System.out.println("customerUserName: " + customerUserName);
			String customerPassword = request.getParameter("regPassword");
			System.out.println("customerPassword: " + customerPassword);
			String customerFirstName = request.getParameter("regFirstName");
			System.out.println("customerFirstName: " + customerFirstName);
			String customerLastName = request.getParameter("regLastName");
			System.out.println("customerLastName: " + customerLastName);
			String customerAddress = request.getParameter("regAddress");
			System.out.println("customerAddress: " + customerAddress);
			String customerCity = request.getParameter("regCity");
			System.out.println("customerCity: " + customerCity);
			String customerPostalCode = request.getParameter("regPostalCode");
			System.out.println("customerPostalCode: " + customerPostalCode);
			con = ConnectionFactory.getConnection();

			String addCustomerQuery = "UPDATE Customers SET customerPassword=?, customerFirstName=?, "+
					"customerLastName=?, customerAddress=?, customerCity=?, customerPostalCode=?"
					+ " WHERE customerUserName = ?";
			
			pst = con.prepareStatement(addCustomerQuery);
			System.out.println("pst before: " + pst);  						
			pst.setString(1, customerPassword);
			pst.setString(2, customerFirstName);						
			pst.setString(3, customerLastName);
			pst.setString(4, customerAddress);							
			pst.setString(5, customerCity);
			pst.setString(6, customerPostalCode);
			pst.setString(7, customerUserName);
			System.out.println("editCustomerQuery: " + addCustomerQuery);
			System.out.println("editCustomerQuery: 2");
			System.out.println("pst after: " + pst);
			pst.executeUpdate();
			System.out.println("editCustomerQuery: 3");
			session.setAttribute("InfoEditted", true);
			
			
			
			if ("Edit".equals(action)) {
				Customer existingCxLogIn = (Customer)session.getAttribute("CxLogIn");
				existingCxLogIn.setCxPassword(customerPassword);
				existingCxLogIn.setCxFirstName(customerFirstName);
				existingCxLogIn.setCxLastName(customerLastName);
				existingCxLogIn.setCxAddress(customerAddress);
				existingCxLogIn.setCxCity(customerCity);
				existingCxLogIn.setCxPostalCode(customerPostalCode);
				RequestDispatcher rd = request.getRequestDispatcher("AccountInfo.jsp");
				rd.forward(request, response);
				
			}
			if ("EditCustomerInfo".equals(action)) {
				Customer edittedCustomerByCSR = (Customer)session.getAttribute("customerToEdit");
				edittedCustomerByCSR.setCxPassword(customerPassword);
				edittedCustomerByCSR.setCxFirstName(customerFirstName);
				edittedCustomerByCSR.setCxLastName(customerLastName);
				edittedCustomerByCSR.setCxAddress(customerAddress);
				edittedCustomerByCSR.setCxCity(customerCity);
				edittedCustomerByCSR.setCxPostalCode(customerPostalCode);
				RequestDispatcher rd = request.getRequestDispatcher("EditCustomerInfo.jsp");
				rd.forward(request, response);
				
			}
			
		}
		catch (Exception e) {
			
		}
	}


	
	public void registration (HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			System.out.println("CustomerController.jsp > registration()");
			String customerUserName = request.getParameter("regUserName");
			System.out.println("customerUserName: " + customerUserName);
			String customerPassword = request.getParameter("regPassword");
			System.out.println("customerPassword: " + customerPassword);
			String customerFirstName = request.getParameter("regFirstName");
			System.out.println("customerFirstName: " + customerFirstName);
			String customerLastName = request.getParameter("regLastName");
			System.out.println("customerLastName: " + customerLastName);
			String customerAddress = request.getParameter("regAddress");
			System.out.println("customerAddress: " + customerAddress);
			String customerCity = request.getParameter("regCity");
			System.out.println("customerCity: " + customerCity);
			String customerPostalCode = request.getParameter("regPostalCode");
			System.out.println("customerPostalCode: " + customerPostalCode);
			con = ConnectionFactory.getConnection();

			String addCustomerQuery = "Insert into Customers "
					+ "(customerUserName, customerPassword, customerFirstName, customerLastName, customerAddress, customerCity, customerPostalCode)"
					+ "values (?, ?, ?, ?, ?, ?, ?)";
			System.out.println("addCustomerQuery: " + addCustomerQuery);
			pst = con.prepareStatement(addCustomerQuery);
			System.out.println("addCustomerQuery: 1");
			pst.setString(1, customerUserName);   						pst.setString(2, customerPassword);
			pst.setString(3, customerFirstName);						pst.setString(4, customerLastName);
			pst.setString(5, customerAddress);							pst.setString(6, customerCity);
			pst.setString(7, customerPostalCode);
			System.out.println("addCustomerQuery: 2");
			pst.executeUpdate();
			System.out.println("addCustomerQuery: 3");
			RequestDispatcher rd = request.getRequestDispatcher("LogIn.jsp");
			rd.forward(request, response);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			ConnectionFactory.closeConnection(con, pst, null);
		}
	}
	
	
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}