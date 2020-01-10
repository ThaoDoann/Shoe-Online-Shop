package Model;

import java.io.Serializable;

public class CSR  implements Serializable{
	private int employeeId;
	private String userName;
	private String password;
	private String firstName;
	private String lastName;
	
	public CSR (){
		
	}
	
	public CSR(int employeeId, String userName, String password, String firstName, String lastName) {
		super();
		this.employeeId = employeeId;
		this.userName = userName;
		this.password = password;
		this.firstName = firstName;
		this.lastName = lastName;
	}
	public int getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	
	
}
