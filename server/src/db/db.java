package db;

import java.sql.Connection;
import java.sql.DriverManager;

// data base manager
public class db {
	public static void main(String args[]){
		Connection c = null;
		try{
			Class.forName("org.postgresql.Driver");
			c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/td", "postgres", "Q19870816q");
		
		
			System.out.println("connected");
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("error");
		}
	}
}
