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
import Model.Employee;

/**
 * Servlet implementation class LogInController
 */
@WebServlet("/LogInController")
public class LogInController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static HttpSession session ;	
	static Connection con = null;
	PreparedStatement pst;
	static ResultSet rs = null;
	Statement st;
	boolean isUserValid;
	boolean isEmployeeValid;
	
    public LogInController() {
    	super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println("LogInController.jsp > doGet()");
			session = request.getSession();			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();			
			String action = request.getParameter("action");
			
			if ("SignIn".equals(action)) {
				session = request.getSession();		
				System.out.println("LogInController.jsp > doGet() > SignIn Clicked");
				login (request, response);	
				
			}
			if("SignOut".equals(action)) {
				System.out.println("LogInController.jsp > doGet() > SignOut Clicked");
				logout (request, response);
			}
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/**
	 * Check if the user name and password is valid
	 * @param userType: customer or employee (which table)
	 */

	public void login (HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			System.out.println("LogInController.jsp > login()");
			String UserName = request.getParameter("regUserName");
			String Password = request.getParameter("regPassword");
			String userType = request.getParameter("userType");
			con = ConnectionFactory.getConnection();
			String query="";
			if (userType.equals("Customers")) {
				System.out.println("LogInController.jsp > login() > when userType is Customers");
				query = "select * from "+ userType +" where customerUserName = ? and customerPassword = ?";
			}
			else if (userType.equals("CSR")) {
				System.out.println("LogInController.jsp > login() > when userType is CSR");
				query = "select * from "+ userType +" where employeeUserName = ? and employeePassword = ?";
			}
			System.out.println("query: "+query);
			pst = con.prepareStatement(query);
			pst.setString(1, UserName);			
			pst.setString(2, Password);		
			rs = pst.executeQuery();
			
			
			while(rs.next()) {
				System.out.println("LogInController.jsp > login() > while loop when rs has next");
				String userNameReturn = rs.getString(2);
				System.out.println("userNameReturn : " + userNameReturn);
				String passwordReturn = rs.getString(3);
				System.out.println("passwordReturn : " + passwordReturn);
				if(userNameReturn.equals(UserName) && passwordReturn.equals(Password) ) {
					System.out.println("LogInController.jsp > login() > while loop > if");
					System.out.println("Login() > While loop > first If statement");
					if(userType.equals("Customers")) {
						System.out.println("LogInController.jsp > login() > while loop > if > if(Cx)");
						isUserValid = true;
					}
						 
					else if (userType.equals("CSR")) {
						System.out.println("LogInController.jsp > login() > while loop > if > else if(CSR)");
						isEmployeeValid = true;
					}						
					System.out.println("isUserValid: "+isUserValid);
					break;
				}				
			}			
			
			
			if (isUserValid) {
				System.out.println("LogInController.jsp > login() > if(Cx)");
				session.setAttribute("logInFailed", false);
				Customer existingCxLogIn = new Customer();
				existingCxLogIn.setCxID(rs.getInt(1));		
				System.out.println("Customer ID : "+existingCxLogIn.getCxID());
				existingCxLogIn.setCxUserName(UserName);
				System.out.println("Customer Username : "+existingCxLogIn.getCxUserName());
				existingCxLogIn.setCxPassword(Password);
				System.out.println("Customer PW : "+existingCxLogIn.getCxPassword());
				existingCxLogIn.setCxFirstName(rs.getString(4));
				System.out.println("Customer firstName : "+existingCxLogIn.getCxFirstName());
				existingCxLogIn.setCxLastName(rs.getString(5));
				System.out.println("Customer last name : "+existingCxLogIn.getCxLastName());
				existingCxLogIn.setCxAddress(rs.getString(6));
				System.out.println("Customer Address : "+existingCxLogIn.getCxAddress());
				existingCxLogIn.setCxCity(rs.getString(7));
				System.out.println("Customer city : "+existingCxLogIn.getCxCity());
				existingCxLogIn.setCxPostalCode(rs.getString(8));
				System.out.println("Customer Postal Code : "+existingCxLogIn.getCxPostalCode());
				session.setAttribute("CxLogIn", existingCxLogIn);
				System.out.println("session.getAttribute(\"CxLogIn\"): "+session.getAttribute("CxLogIn"));
				session.setAttribute("isLoggedIn", true);
				System.out.println("session.getAttribute(\"isLoggedIn\"): "+session.getAttribute("isLoggedIn"));
				session.setAttribute("LogInType", userType);
				System.out.println("session.getAttribute(\"LogInType\"): "+session.getAttribute("LogInType"));
				if (session.getAttribute("logInFailed") != null) {
					System.out.println("LogInController.jsp > logout() > logInFailedDestroy");
					session.removeAttribute("logInFailed");
					System.out.println("session.getAttribute(\"logInFailed\"): "+session.getAttribute("logInFailed"));	
				}
				RequestDispatcher rd = request.getRequestDispatcher("SuccessfulLogIn.jsp");
				rd.forward(request, response);
				
//				response.sendRedirect("SuccessfulLogIn.jsp");
			}
			else if (isEmployeeValid) {
				System.out.println("LogInController.jsp > login() > elsen if(CSR)");
				session.setAttribute("logInFailed", false);
				Employee existingEmplLogIn = new Employee();
				existingEmplLogIn.setEmplID(rs.getInt(1));		
				System.out.println("Employee ID : "+existingEmplLogIn.getEmplID());
				existingEmplLogIn.setEmplUserName(UserName);
				System.out.println("Employee Username : "+existingEmplLogIn.getEmplUserName());
				existingEmplLogIn.setEmplPassword(Password);
				System.out.println("Employee PW : "+existingEmplLogIn.getEmplPassword());
				existingEmplLogIn.setEmplFirstName(rs.getString(4));
				System.out.println("Employee firstName : "+existingEmplLogIn.getEmplFirstName());
				existingEmplLogIn.setEmplLastName(rs.getString(5));
				System.out.println("Employee last name : "+existingEmplLogIn.getEmplLastName());
				existingEmplLogIn.setEmplAddress(rs.getString(6));
				System.out.println("Employee Address : "+existingEmplLogIn.getEmplAddress());
				existingEmplLogIn.setEmplCity(rs.getString(7));
				System.out.println("Employee city : "+existingEmplLogIn.getEmplCity());
				existingEmplLogIn.setEmplPostalCode(rs.getString(8));
				System.out.println("Employee Postal Code : "+existingEmplLogIn.getEmplPostalCode());
				session.setAttribute("EmplLogIn", existingEmplLogIn);
				System.out.println("session.getAttribute(\"EmplLogIn\"): "+session.getAttribute("EmplLogIn"));
				session.setAttribute("isLoggedIn", true);
				System.out.println("session.getAttribute(\"isLoggedIn\"): "+session.getAttribute("isLoggedIn"));
				session.setAttribute("LogInType", userType);
				System.out.println("session.getAttribute(\"LogInType\"): "+session.getAttribute("LogInType"));
				if (session.getAttribute("logInFailed") != null) {
					System.out.println("LogInController.jsp > logout() > logInFailedDestroy");
					session.removeAttribute("logInFailed");
					System.out.println("session.getAttribute(\"logInFailed\"): "+session.getAttribute("logInFailed"));	
				}
				RequestDispatcher rd = request.getRequestDispatcher("SuccessfulLogIn.jsp");
				rd.forward(request, response);
			}
			else {
				System.out.println("LogInController.jsp > login() > else (log in failed)");
				session.setAttribute("logInFailed", true);
				RequestDispatcher rd = request.getRequestDispatcher("LogIn.jsp");
				rd.forward(request, response);
			}
		}
		catch (Exception e) {
			
		}
	}
	
	public void logout (HttpServletRequest request, HttpServletResponse response) throws Exception {
		isEmployeeValid = false;
		isUserValid = false;
		System.out.println("LogInController.jsp > logout()");
//		session.invalidate();
		if (session.getAttribute("EmplLogIn") != null) {
			System.out.println("LogInController.jsp > logout() > EmplLogInDestroy");
			session.removeAttribute("EmplLogIn");
			System.out.println("session.getAttribute(\"EmplLogIn\"): "+session.getAttribute("EmplLogIn"));
		}
		if (session.getAttribute("CxLogIn") != null) {
			System.out.println("LogInController.jsp > logout() > CxLogInDestroy");
			session.removeAttribute("CxLogIn");
			System.out.println("session.getAttribute(\"CxLogIn\"): "+session.getAttribute("CxLogIn"));
		}
		if (session.getAttribute("isLoggedIn") != null) {
			System.out.println("LogInController.jsp > logout() > isLoggedInDestroy");
			session.removeAttribute("isLoggedIn");
			System.out.println("session.getAttribute(\"isLoggedIn\"): "+session.getAttribute("isLoggedIn"));
		}
		if (session.getAttribute("LogInType") != null) {
			System.out.println("LogInController.jsp > logout() > LogInTypeDestroy");
			session.removeAttribute("LogInType");
			System.out.println("session.getAttribute(\"LogInType\"): "+session.getAttribute("LogInType"));
		}
		if (session.getAttribute("InfoEditted") != null) {
			System.out.println("LogInController.jsp > logout() > InfoEdittedDestroy");
			session.removeAttribute("InfoEditted");
			System.out.println("session.getAttribute(\"InfoEditted\"): "+session.getAttribute("InfoEditted"));	
		}
		if (session.getAttribute("logInFailed") != null) {
			System.out.println("LogInController.jsp > logout() > logInFailedDestroy");
			session.removeAttribute("logInFailed");
			System.out.println("session.getAttribute(\"logInFailed\"): "+session.getAttribute("logInFailed"));	
		}
		if (session.getAttribute("customerToEdit") != null) {
			System.out.println("LogInController.jsp > logout() > customerToEditDestroy");
			session.removeAttribute("logInFailed");
			System.out.println("session.getAttribute(\"customerToEdit\"): "+session.getAttribute("customerToEdit"));	
		}
		
		
		
		
		
		
			
		response.sendRedirect("LogIn.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
