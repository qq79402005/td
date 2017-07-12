package player;

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
	public int 				  cell_number = 12;
	protected ArrayList<cell> cells;
	
	public Backpack() {
		
	}
	
	public void init() {
		
	}
	
	// used for save to db
	public void str() {
		
	}
}
