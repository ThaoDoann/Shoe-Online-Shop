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
 * Servlet implementation class EmployeeController
 */
@WebServlet("/EmployeeController")
public class EmployeeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static HttpSession session ;	
	static Connection con = null;
	PreparedStatement pst;
	static ResultSet rs = null;
	Statement st;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EmployeeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			System.out.println("EmployeeController.jsp > doGet()");
			session = request.getSession();			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();			
			String action = request.getParameter("action");
			
			
			if ("Edit".equals(action)) {
				System.out.println("CustomerController.jsp > doGet() > AccountInfo Save Changes Btn Clicked");
				editEmployee (request, response);	
				
			}
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		
	}
	

	public void editEmployee(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			System.out.println("EmployeeController.jsp > editEmployee()");
			System.out.println("Session, userName : "+session.getAttribute("userName"));
			String employeeUserName = request.getParameter("regUserName");
			System.out.println("employeeUserName: " + employeeUserName);
			String employeePassword = request.getParameter("regPassword");
			System.out.println("employeePassword: " + employeePassword);
			String employeeFirstName = request.getParameter("regFirstName");
			System.out.println("employeeFirstName: " + employeeFirstName);
			String employeeLastName = request.getParameter("regLastName");
			System.out.println("employeeLastName: " + employeeLastName);
			String employeeAddress = request.getParameter("regAddress");
			System.out.println("employeeAddress: " + employeeAddress);
			String employeeCity = request.getParameter("regCity");
			System.out.println("employeeCity: " + employeeCity);
			String employeePostalCode = request.getParameter("regPostalCode");
			System.out.println("employeePostalCode: " + employeePostalCode);
			con = ConnectionFactory.getConnection();

			String addEmployeeQuery = "UPDATE CSR SET employeePassword=?, employeeFirstName=?, "+
					"employeeLastName=?, employeeAddress=?, employeeCity=?, employeePostalCode=?"
					+ " WHERE employeeUserName = ?";
			
			pst = con.prepareStatement(addEmployeeQuery);
			System.out.println("editEmployeeQuery: 1");   						
			pst.setString(1, employeePassword);
			pst.setString(2, employeeFirstName);						
			pst.setString(3, employeeLastName);
			pst.setString(4, employeeAddress);							
			pst.setString(5, employeeCity);
			pst.setString(6, employeePostalCode);
			pst.setString(7, employeeUserName);
			System.out.println("editEmployeeQuery: " + addEmployeeQuery);
			System.out.println("editEmployeeQuery: 2");
			pst.executeUpdate();
			Employee existingEmplLogIn = (Employee)session.getAttribute("EmplLogIn");
			
			existingEmplLogIn.setEmplPassword(employeePassword);
			System.out.println("employee PW : "+existingEmplLogIn.getEmplPassword());
			existingEmplLogIn.setEmplFirstName(employeeFirstName);
			System.out.println("employee firstName : "+existingEmplLogIn.getEmplFirstName());
			existingEmplLogIn.setEmplLastName(employeeLastName);
			System.out.println("employee last name : "+existingEmplLogIn.getEmplLastName());
			existingEmplLogIn.setEmplAddress(employeeAddress);
			System.out.println("employee Address : "+existingEmplLogIn.getEmplAddress());
			existingEmplLogIn.setEmplCity(employeeCity);
			System.out.println("employee city : "+existingEmplLogIn.getEmplCity());
			existingEmplLogIn.setEmplPostalCode(employeePostalCode);
			System.out.println("employee city : "+existingEmplLogIn.getEmplPostalCode());
			
//			cxInfoEditted++;
			session.setAttribute("InfoEditted", true);
			System.out.println("editEmployeeQuery: 3");
//			if(addCustomer > 0 ) {
//				System.out.println("CustomerController.jsp > registration() > if");
//				Customer newCustomer = new Customer();
//				newCustomer.setCxFirstName(customerFirstName);
//				newCustomer.setCxLastName(customerLastName);//				
//				}		
			
			if(session.getAttribute("EmplLogIn") != null) {
				Employee employee = (Employee) session.getAttribute("EmplLogIn");
				int employeeId = employee.getEmplID(); 
				Employee existingEmpLogIn = new Employee (employeeId, employeeUserName, employeePassword, employeeFirstName, employeeLastName, employeeAddress
						,employeeCity, employeePostalCode );
				session.setAttribute("EmplLogIn", existingEmpLogIn);
			}
			
			RequestDispatcher rd = request.getRequestDispatcher("CSR_EmployeeInfo.jsp");
			rd.forward(request, response);
//			response.sendRedirect("AccountInfo.jsp");
		}
		catch (Exception e) {
			
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
