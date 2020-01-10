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
import Model.Shoe;
/**
 * Servlet implementation class ProductController
 */
@WebServlet("/ProductController")
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static HttpSession session ;
	static Connection con = null;
	PreparedStatement pst;
	static ResultSet rs = null;
	Statement st;     
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		try{
			session = request.getSession();
			response.setContentType("text/html");
			
			String action = request.getParameter("action");
		
			if("addProduct".equals(action)) {
				addProduct(request, response);
			}else if ("editProduct".equals(action)) {
				editProduct(request, response);
			}else if ("deleteProduct".equals(action)) {
				deleteProduct(request, response);
			}else if ("forwardEdit".equals(action)) {
				forwardEditPage(request, response);
			}
			
		}catch (Exception ex) {
			ex.printStackTrace();
		}
	}


	public void addProduct (HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			con = ConnectionFactory.getConnection();
			String itemName = request.getParameter("addItemName");
			String category = request.getParameter("addCategory");
			int shoeSize = Integer.parseInt(request.getParameter("addItemSize"));
			double price = Double.parseDouble(request.getParameter("addPrice"));
			int quantity = Integer.parseInt(request.getParameter("addQty"));
			String imgPath = request.getParameter("imagePath");
			System.out.println(imgPath);
			String description = request.getParameter("addDescription");
			
			pst = con.prepareStatement("insert into Shoes (itemName, category, shoeSize, price, quantity, image, description) "
					+ "values (?, ?, ?, ?, ?,?, ?)");
			pst.setString(1,itemName );
			pst.setString(2, category);
			pst.setInt(3, shoeSize);
			pst.setDouble(4, price);
			pst.setInt(5, quantity);
			pst.setString(6, ("images/"+category+"_Shoes/"+imgPath));
			System.out.println("add image: "+imgPath);
			pst.setString(7, description);
	
			int newItem = pst.executeUpdate();
	
			RequestDispatcher rd=request.getRequestDispatcher("CSR_Product.jsp");  
			rd.forward(request, response);
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionFactory.closeConnection(con, pst, null);
		}
	}
	
	public void editProduct (HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			con = ConnectionFactory.getConnection();
			String itemName = request.getParameter("editItemName");
			String category = request.getParameter("editCategory");
			int shoeSize = Integer.parseInt(request.getParameter("editItemSize"));
			double price = Double.parseDouble(request.getParameter("editPrice"));
			int quantity = Integer.parseInt(request.getParameter("editQty"));
			String imgPath = request.getParameter("editImg");
			System.out.println("edit image: "+imgPath);
			String description = request.getParameter("editDescription");
			
			int itemId = Integer.parseInt(request.getParameter("editItemId"));
			
			pst = con.prepareStatement("update Shoes set itemName = ?, category = ?, shoeSize =?, price = ?, quantity =?, "
					+ "image = ?, description = ? where itemId = ?");
			pst.setString(1,itemName );
			pst.setString(2, category);
			pst.setInt(3, shoeSize);
			pst.setDouble(4, price);
			pst.setInt(5, quantity);
			pst.setString(6, ("images/"+category+"_Shoes/"+imgPath));
			System.out.println("images/"+category+"_Shoes/"+imgPath);
			pst.setString(7, description);
			pst.setInt(8, itemId);
	
			int newItem = pst.executeUpdate();
			System.out.println(newItem +" has been edited");
			RequestDispatcher rd=request.getRequestDispatcher("CSR_Product.jsp");  
			rd.forward(request, response);
			
		}
		catch(Exception e) {
			
		}finally {
			ConnectionFactory.closeConnection(con, pst, null);
		}
	}
	
	public void deleteProduct (HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			
			con = ConnectionFactory.getConnection();
			String products [] = request.getParameterValues("product");
			if (products != null) {
				for (int i= 0; i< products.length; i++) {
					int itemId = Integer.parseInt(products[i]);
					if (productIsOrdered(itemId)) {
						System.out.println("can not delete");
						request.setAttribute("denyMsg", "Can not delete this item. This item has been ordered");
					}else {
						System.out.println("can delete");
						pst = con.prepareStatement("Delete from Shoes where itemId = ? AND itemId NOT IN "
								+ "(select itemId from orders)");
						pst.setInt(1, itemId);
						
						int deleteItems = pst.executeUpdate();
						if(deleteItems > 0 ) {
							System.out.println("Number of products have been deleted :" + deleteItems);      
						}
					}
				}
			}
			RequestDispatcher rd=request.getRequestDispatcher("CSR_Product.jsp");  
			rd.forward(request, response);			
		}
		catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionFactory.closeConnection(con, pst, null);
		}
	}
	
	public void forwardEditPage (HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			String itemId = request.getParameter("product");
			if(itemId != null) {
				RequestDispatcher rd=request.getRequestDispatcher("CSR_EditProduct.jsp");  
				rd.forward(request, response);	
			}else {
				RequestDispatcher rd=request.getRequestDispatcher("CSR_Product.jsp");  
				rd.forward(request, response);	
			}
					
		}
		catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionFactory.closeConnection(con, pst, null);
		}
	}



	/*
	 * To check if the itemId is available in the Order table
	 */
	public boolean productIsOrdered (int itemId) throws Exception {
		boolean isOrdered= false;
		try {
			con = ConnectionFactory.getConnection();
			pst = con.prepareStatement("select COUNT(*) from orders where itemId = ?");
			pst.setInt(1, itemId);

			rs = pst.executeQuery();
			if(rs.next()) {
				if (rs.getInt(1) > 0) {
					isOrdered = true;
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return isOrdered;
	}
		
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}




