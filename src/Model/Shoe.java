package Model;

import java.io.Serializable;
import java.sql.*;
import Controller.ConnectionFactory;
import java.sql.Connection;
import java.util.ArrayList;


public class Shoe implements Serializable{
	Connection connection = null;
	ResultSet rs = null;
	PreparedStatement pst = null;
	Statement st = null;

	
	private int itemId;
	private String itemName;
	private String category;
	private int shoeSize;
	private double price;
	private int quantity;
	private String image;
	private String description;


	public Shoe() {
	}


	public Shoe(int itemId, String itemName, String category, int shoeSize, double price, int quantity, String image,
			String description) {
		super();
		this.itemId = itemId;
		this.itemName = itemName;
		this.category = category;
		this.shoeSize = shoeSize;
		this.price = price;
		this.quantity = quantity;
		this.image = image;
		this.description = description;
	}

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getShoeSize() {
		return shoeSize;
	}

	public void setShoeSize(int shoeSize) {
		this.shoeSize = shoeSize;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}
	
	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	//get all ordered shoes
	public ArrayList<Shoe> getShoeList () throws Exception{
		ArrayList<Shoe>  shoeList = null;
		try {
			connection = ConnectionFactory.getConnection();
			pst = connection.prepareStatement("Select * from Shoes ");
			rs = pst.executeQuery();
			
			
			shoeList = new ArrayList<Shoe>();
			while(rs.next()){
				shoeList.add(new Shoe (rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), 
						rs.getDouble(5), rs.getInt(6), rs.getString(7), rs.getString(8)));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			ConnectionFactory.closeConnection(connection, pst, null);
		}
		return shoeList;
	}
	
	public ArrayList<Shoe> showShoeList (String category) throws Exception{
		ArrayList<Shoe>  shoeList = null;
		try {
			connection = ConnectionFactory.getConnection();
			pst = connection.prepareStatement("Select * from Shoes Where category = ?");
			pst.setString(1, category);
			rs = pst.executeQuery();
			
			shoeList = new ArrayList<Shoe>();
			while(rs.next()){
				shoeList.add(new Shoe (rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), 
						rs.getDouble(5), rs.getInt(6), rs.getString(7), rs.getString(8)));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			ConnectionFactory.closeConnection(connection, pst, null);
		}
		return shoeList;
	}
	
	
	
	/*
	 * Get item information when we know its itemId
	 */
	public Shoe getShoe (int itemId) throws Exception{
		Shoe shoe = new Shoe();
		try {
			connection = ConnectionFactory.getConnection();
			pst = connection.prepareStatement("Select * from Shoes Where itemId = ?");
			pst.setInt(1, itemId);
			rs = pst.executeQuery();

			if(rs.next()){
				shoe = new Shoe (rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), 
						rs.getDouble(5), rs.getInt(6), rs.getString(7), rs.getString(8));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			ConnectionFactory.closeConnection(connection, pst, null);
		}
		return shoe;
	}
//	
//	/*
//	 * return an array of same shoe but different sizes
//	 */
//	
//	public ArrayList<Integer> getShoeSize (int itemName, String category, double price) throws Exception {
//		try {
//			connection = ConnectionFactory.getConnection();
//			pst = connection.prepareStatement("SELECT shoeSize FROM Shoes WHERE itemName = ? AND category =? AND price =?");
//			rs = pst.executeQuery();
//			
//			while(rs.next()){
//				orderList.add(new Order (rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getDate(4), rs.getInt(5), rs.getString(6)));
//			}
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//		}finally {
//			ConnectionFactory.closeConnection(connection, pst, null);
//		}
//		return orderList;
//	}
	
	
}
