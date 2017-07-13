package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import player.Player;

// data base manager
public class db {
	protected static db inst = null;
	protected Connection con = null;
	
	/*public static void main(String args[]){
		Connection c = null;
		try{
			Class.forName("org.postgresql.Driver");
			c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/td", "postgres", "Q19870816q");
		
		
			System.out.println("connected");
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("error");
		}
	}*/
	public db() {
		try {
			//Class.forName("org.postgresql.Driver");
			con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/td", "postgres", "Q19870816q");		
			System.out.println("db:connected");		
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public static db instance() {
		if(inst==null)
			inst = new db();

		return inst;
	}
	
	public boolean isPlayerExist(String name) {
		try {
			int rows = 0;
			Statement st = con.createStatement();
			
			String sql = String.format("SELECT COUNT(id) AS rows FROM player WHERE name=\'%s\';", name);
			ResultSet rs = st.executeQuery(sql);
			if(rs.next()) {
				rows = rs.getInt("rows");
			}
			rs.close();
			
			if(rows>0) {
				return true;
			}else {
				return false;
			}			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
			
		return true;
	}
	
	public void saveNewPlayer(String account, String name, String json) {
		try {
			Statement st = con.createStatement();
			
			String sql = String.format("INSERT INTO player(account,name,info) VALUES(\'%s\', \'%s\', \'%s\');", account, name, json);
			
			System.out.println("db:" + sql);
			st.executeUpdate(sql);
			st.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void savePlayer(Player player) {
		
	}
	
	public void getPlayerInfo(int id) {
		try{		
			/*Statement st = con.createStatement();
			st.executeQuery("SELECT * FROM player WHERE name=\"qq79402005\"");*/
				
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
