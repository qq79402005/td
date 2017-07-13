package player;

import db.db;
import java.util.ArrayList;

class cell{
	int		item_id;
	int		item_num;
	
	cell(){
		item_id = 0;
		item_num = 0;
	}
}

public class Backpack {
	public int 				  cell_number = 15;
	protected ArrayList<cell> cells;
	
	public Backpack() {
		
	}
	
	public void init(String account) {
		//db.instance().getPlayerInfo(account);
	}
	
	// used for save to db
	public void str() {
		
	}
}
