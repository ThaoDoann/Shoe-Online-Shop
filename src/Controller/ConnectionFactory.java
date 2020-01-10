package Controller;
/**
 * Student Name: Doan Ngoc Phuong Thao - 991466176
 */

import java.sql.*;

public class ConnectionFactory {
	
		
		private static final String url="jdbc:mysql://localhost:3306/MVCDB";
	    private static final String user="root";
	    private static final String password="root";

	    private ConnectionFactory() throws InstantiationException, IllegalAccessException {
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		}
 
	    /**
	     * to connect to database everytime we use a query
	     * @exception if we can't connect to MySQL
	     */
	    public static Connection getConnection() throws Exception{
	    	Connection connection = null;
			try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				connection = DriverManager.getConnection(url, user, password);
				
			} catch (SQLException e) {
				System.out.println("ERROR: Connection Failed "+e.getMessage());
			}
			return connection;

	   }
	 
	    /**
	     * terminate connection after executing each query
	     * @throws Exception if an error occurs
	     */
	    public static void closeConnection(Connection con, Statement st, ResultSet rs) throws Exception{
	            if(con!=null)
	                    con.close();
	            if(st!=null)
	                    st.close();
	            if(rs!=null)
	                    rs.close();
	    }
	
	    // Test by MJ

}
