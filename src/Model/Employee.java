package Model;

import java.io.Serializable;

public class Employee implements Serializable {
	private int emplID;
	private String emplUserName;
	private String emplPassword;
	private String emplFirstName;
	private String emplLastName;
	private String emplAddress;
	private String emplCity;
	private String emplPostalCode;
	
	public Employee() {
		
	}
	
	
	
	public Employee(int emplID, String emplUserName, String emplPassword, String emplFirstName, String emplLastName,
			String emplAddress, String emplCity, String emplPostalCode) {
		super();
		this.emplID = emplID;
		this.emplUserName = emplUserName;
		this.emplPassword = emplPassword;
		this.emplFirstName = emplFirstName;
		this.emplLastName = emplLastName;
		this.emplAddress = emplAddress;
		this.emplCity = emplCity;
		this.emplPostalCode = emplPostalCode;
	}
	public int getEmplID() {
		return emplID;
	}
	public void setEmplID(int emplID) {
		this.emplID = emplID;
	}
	public String getEmplUserName() {
		return emplUserName;
	}
	public void setEmplUserName(String emplUserName) {
		this.emplUserName = emplUserName;
	}
	public String getEmplPassword() {
		return emplPassword;
	}
	public void setEmplPassword(String emplPassword) {
		this.emplPassword = emplPassword;
	}
	public String getEmplFirstName() {
		return emplFirstName;
	}
	public void setEmplFirstName(String emplFirstName) {
		this.emplFirstName = emplFirstName;
	}
	public String getEmplLastName() {
		return emplLastName;
	}
	public void setEmplLastName(String emplLastName) {
		this.emplLastName = emplLastName;
	}
	public String getEmplAddress() {
		return emplAddress;
	}
	public void setEmplAddress(String emplAddress) {
		this.emplAddress = emplAddress;
	}
	public String getEmplCity() {
		return emplCity;
	}
	public void setEmplCity(String emplCity) {
		this.emplCity = emplCity;
	}
	public String getEmplPostalCode() {
		return emplPostalCode;
	}
	public void setEmplPostalCode(String emplPostalCode) {
		this.emplPostalCode = emplPostalCode;
	}
	
	

}



