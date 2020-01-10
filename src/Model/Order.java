package Model;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import Controller.ConnectionFactory;

public class Order implements Serializable{
	Connection connection = null;
	PreparedStatement pst;
	ResultSet rs = null;
	Statement st; 
	ArrayList<Order> orderList = new ArrayList<Order>();
	
	private int orderId;
	private int customerId;
	private int itemId;
	private Date orderDate;
	private int quantity;
	private String status;
	
	public Order() {
	}

	public Order(int orderId, int customerId, int itemId, Date orderDate, int quantity, String status) {
		super();
		this.orderId = orderId;
		this.customerId = customerId;
		this.itemId = itemId;
		this.orderDate = orderDate;
		this.quantity = quantity;
		this.status = status;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public ArrayList<Order> getOderList () throws Exception {
		try {
			connection = ConnectionFactory.getConnection();
			st = connection.createStatement();
			rs = st.executeQuery("Select * from Orders");
			while(rs.next()){
				orderList.add(new Order (rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getDate(4), rs.getInt(5), rs.getString(6)));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionFactory.closeConnection(connection, pst, null);
		}
		return orderList;
	}
	
	public ArrayList<Order> getCustomerCart (int customerId) throws Exception {
		try {
			connection = ConnectionFactory.getConnection();
			st = connection.createStatement();
			rs = st.executeQuery("Select * from Orders where customerId = "+customerId);
			
			while(rs.next()){
				orderList.add(new Order (rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getDate(4), rs.getInt(5), rs.getString(6)));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionFactory.closeConnection(connection, pst, null);
		}
		return orderList;
	}
	
	
	
}
