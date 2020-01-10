package Model;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import Controller.ConnectionFactory;


public class Customer implements Serializable{

	ArrayList <Customer> customerList = new ArrayList<Customer> ();
	static Connection con = null;
	static ResultSet rs = null;
	Statement st;
	
	private int cxID;
	private String cxUserName;
	private String cxPassword;
	private String cxFirstName;
	private String cxLastName;
	private String cxAddress;
	private String cxCity;
	private String cxPostalCode;
	
	public ArrayList <Customer> getCustomerList () throws Exception{
		try {
			System.out.println("Customer.java > Arraylist of Customers, getCustomerList()");			
			con = ConnectionFactory.getConnection();
			st = con.createStatement();
			rs = st.executeQuery("Select * from Customers");
			
			System.out.println("Customer.java > Arraylist of Customers, getCustomerList() > if ReseltSet has next??");
			while(rs.next()){
				
				customerList.add(new Customer (rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8)));
				System.out.println("Cx Info : " + rs.getInt(1) +" | "+ rs.getString(2) +" | "+ rs.getString(3) +" | "+ rs.getString(4) +" | "+ rs.getString(5) +" | "+ rs.getString(6) +" | "+ rs.getString(7) +" | "+ rs.getString(8));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return customerList;
	}
	
	public Customer getCustomerInfo (int cxID) throws Exception{
		Customer customer = new Customer ();
		try {
			System.out.println("Customer.java > getCustomerInfo()");			
			System.out.println("cxID: "+cxID);
			con = ConnectionFactory.getConnection();
			st = con.createStatement();
			rs = st.executeQuery("Select * from Customers where customerID = " + cxID);
			System.out.println("Customer.java > getCustomerInfo() > if ReseltSet has next?");	
			if (rs.next()){				
				customer = new Customer (rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8));
				System.out.println("Cx Info : " + rs.getInt(1) +" | "+ rs.getString(2) +" | "+ rs.getString(3) +" | "+ rs.getString(4) +" | "+ rs.getString(5) +" | "+ rs.getString(6) +" | "+ rs.getString(7) +" | "+ rs.getString(8));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return customer;
	}
	
	
	public Customer () {
		
	}
	
	

	public Customer(int cxID, String cxUserName, String cxPassword, String cxFirstName, String cxLastName,
			String cxAddress, String cxCity, String cxPostalCode) {
		super();
		this.cxID = cxID;
		this.cxUserName = cxUserName;
		this.cxPassword = cxPassword;
		this.cxFirstName = cxFirstName;
		this.cxLastName = cxLastName;
		this.cxAddress = cxAddress;
		this.cxCity = cxCity;
		this.cxPostalCode = cxPostalCode;
	}


	public int getCxID() {
		return cxID;
	}

	public void setCxID(int cxID) {
		this.cxID = cxID;
	}

	public String getCxUserName() {
		return cxUserName;
	}

	public void setCxUserName(String cxUserName) {
		this.cxUserName = cxUserName;
	}

	public String getCxPassword() {
		return cxPassword;
	}

	public void setCxPassword(String cxPassword) {
		this.cxPassword = cxPassword;
	}

	public String getCxFirstName() {
		return cxFirstName;
	}

	public void setCxFirstName(String cxFirstName) {
		this.cxFirstName = cxFirstName;
	}

	public String getCxLastName() {
		return cxLastName;
	}

	public void setCxLastName(String cxLastName) {
		this.cxLastName = cxLastName;
	}

	public String getCxAddress() {
		return cxAddress;
	}

	public void setCxAddress(String cxAddress) {
		this.cxAddress = cxAddress;
	}

	public String getCxCity() {
		return cxCity;
	}

	public void setCxCity(String cxCity) {
		this.cxCity = cxCity;
	}

	public String getCxPostalCode() {
		return cxPostalCode;
	}

	public void setCxPostalCode(String cxPostalCode) {
		this.cxPostalCode = cxPostalCode;
	}
	
	
	

}


