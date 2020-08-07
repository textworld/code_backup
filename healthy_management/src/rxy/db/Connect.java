package rxy.db;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class Connect {

	private static String url="jdbc:sqlserver://localhost:1433;databasename=healthy";
	private static String user="sa";
	private static String password="1273Rxy";
	private static int type = 1;
	private static Connection conn = null;
	private static boolean isconn =false;
 
	public static Connection getConnection() {
		if(isconn){
			return conn;
		}
		try {
			if(type == 1){
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			}else{
				Class.forName("com.mysql.jdbc.Driver");
			}	
		} catch (ClassNotFoundException e) {
			System.out.println("Database Connecter can't find the drive class!");
			e.printStackTrace();
		}
		try {
			conn=DriverManager.getConnection(url,user,password);
		} catch (SQLException e) {
			System.out.print("Cannot connect the databse, please check the status of the database");
			e.printStackTrace();
		}
		if(conn!=null){
			isconn=true;
		}
		
		return conn;		
	}
	
	public static void close(){
		try {
			conn.close();
			isconn = false;
		} catch (SQLException e) {
			System.out.println("Failed to close the connection with database");
			isconn = true;
			e.printStackTrace();
		}		
	}

}
