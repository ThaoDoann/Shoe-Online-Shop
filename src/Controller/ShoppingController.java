package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import Model.Customer;
import Model.Order;
import Model.Shoe;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ShoppingController
 */
@WebServlet("/ShoppingController")
public class ShoppingController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static HttpSession session ;
	static Connection con = null;
	PreparedStatement pst;
	static ResultSet rs = null;
	Statement st;  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShoppingController() {
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			session = request.getSession();
			response.setContentType("text/html");
			String action = request.getParameter("action");
			System.out.println(action);
			
			
			if("deleteCart".equals(action)) {
				deleteCart(request, response);
			}else if ("editCart".equals(action)) {
				editCart(request, response);
			}else if ("editOrder".equals(action)) {
				editOrder(request, response);
			}
			
			//check what shoe the user order
			Shoe shoe = new Shoe();
			ArrayList<Shoe> shoeList = shoe.getShoeList();

			String quantity =request.getParameter("quantity");
			
			boolean isValid = false;
			Customer existingCxLogIn = (Customer)session.getAttribute("CxLogIn");
			for(int i=0; i < shoeList.size(); i++) {
				int itemId = shoeList.get(i).getItemId();

				if(itemId == Integer.parseInt(action)) {
					isValid = true;
					addToCart(itemId, existingCxLogIn.getCxID(), Integer.parseInt(quantity), request, response);
					break;
				}
			}
			
			
		}catch (Exception ex) {

		}
	}
	
public void addToCart (int itemId, int customerId, int quantity, HttpServletRequest request, HttpServletResponse response) throws Exception {
	try {
		con = ConnectionFactory.getConnection();
		String orderId [] = request.getParameterValues("order");
		pst = con.prepareStatement("insert into orders (customerId, itemId, orderDate, quantity, status) values" + 
						"(?, ?, Curdate(), ? , 'Order-Place')");
		pst.setInt(1, customerId);	
		pst.setInt(2, itemId);
		pst.setInt(3, quantity);
				
		System.out.println(pst);
		int deleteItems = pst.executeUpdate();
		if(deleteItems > 0 ) {
			System.out.println("Number of rows have been added :" + deleteItems);      
		}
			
		RequestDispatcher rd=request.getRequestDispatcher("Cart.jsp");  
		rd.forward(request, response);
	}
	catch(Exception e) {
		e.printStackTrace();
	}finally {
		ConnectionFactory.closeConnection(con, pst, null);
	}
}

	
	public void deleteCart (HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			con = ConnectionFactory.getConnection();
			String orderId [] = request.getParameterValues("order");

			if (orderId != null) {
				for (int i= 0; i< orderId.length; i++) {
					pst = con.prepareStatement("Delete from orders where orderId = ?");
					pst.setInt(1, Integer.parseInt(orderId[i]));			
					int deleteItems = pst.executeUpdate();
					if(deleteItems > 0 ) {
						System.out.println("Number of rows have been deleted :" + deleteItems);      
					}
				}
			}
			RequestDispatcher rd=request.getRequestDispatcher("Cart.jsp");  
			rd.forward(request, response);
		}
		catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionFactory.closeConnection(con, pst, null);
		}
	}

	
	public void editCart (HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			con = ConnectionFactory.getConnection();
			Customer existingCxLogIn = (Customer)session.getAttribute("CxLogIn");
			Order order = new Order();
			ArrayList<Order> orders = order.getCustomerCart(existingCxLogIn.getCxID());
			String[] itemSize = request.getParameterValues("shoeSize");
			String[] quantity = request.getParameterValues("cartQty");
			System.out.println("quantity length: "+ quantity.length
					+" itemSize: "+ itemSize.length +" order length: "+ orders.size());
			if (itemSize != null && quantity != null) {
				for (int i= 0; i< quantity.length; i++) {
					int orderId = orders.get(i).getOrderId();

				//update shoe size
					pst = con.prepareStatement("Update Shoes set shoeSize = "+itemSize[i]+ " where itemId = "
							+ "(Select itemId from Orders where orderId = "+orderId+ ")");
					System.out.println(pst);
					pst.executeUpdate();
					
				//update order quantity
					pst = con.prepareStatement("Update Orders set quantity = ? where orderId = ?");
					pst.setInt(1, Integer.parseInt(quantity[i]));
					pst.setInt(2, orderId);	
					pst.executeUpdate();
				
				}
			}
			
			RequestDispatcher rd=request.getRequestDispatcher("Cart.jsp");  
			rd.forward(request, response);
		}
		catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionFactory.closeConnection(con, pst, null);
		}
	}


	
	public void editOrder (HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			Order order = new Order();
			ArrayList<Order> orderList = order.getOderList();
			
			String status []= request.getParameterValues("status");
			
			con = ConnectionFactory.getConnection();
			st = con.createStatement();
			for(int i=0; i< status.length; i++) {
				int orderId = orderList.get(i).getOrderId();
				pst = con.prepareStatement("Update Orders set status = ? where orderId = ?");
				pst.setString(1, status[i]);
				pst.setInt(2, orderId);
				pst.executeUpdate();
			}
			RequestDispatcher rd=request.getRequestDispatcher("CSR_Order.jsp");  
			rd.forward(request, response);
		}
		catch(Exception e) {

			e.printStackTrace();
		}finally {
			ConnectionFactory.closeConnection(con, pst, null);
		}
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
