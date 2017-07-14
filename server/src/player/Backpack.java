package player;

import java.util.ArrayList;
import java.util.Collection;
import com.google.gson.Gson;

class Cell{
	public int		item_id;
	public int		item_num;
	
	Cell(){
		item_id = 0;
		item_num = 0;
	}
	
	Cell(int id, int num){
		item_id = id;
		item_num = num;
	}
}

public class Backpack {
	public int 				  cell_number = 15;
	public ArrayList<Cell> 	  cells = new ArrayList<Cell>();
	
	public Backpack() {
		
	}
	
	public void init(String account) {
		//db.instance().getPlayerInfo(account);
		//cell
	}
	
	// used for save to database
	public String toJson() {	
		Gson gson = new Gson();
		String json = gson.toJson(this);
		
		String backPackJson = String.format("\"backpack\":%s", json);
		return backPackJson;
	}
}
