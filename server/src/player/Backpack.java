package player;

import java.util.ArrayList;

class Cell{
	int		item_id;
	int		item_num;
	
	Cell(){
		item_id = 0;
		item_num = 0;
	}
}

public class Backpack {
	public int 				  cell_number = 15;
	protected ArrayList<Cell> cells;
	
	public Backpack() {
		
	}
	
	public void init(String account) {
		//db.instance().getPlayerInfo(account);
		//cell
	}
	
	// used for save to database
	public String toJson() {	
		String cellsInfo= "";
		for( int i=0; i<cells.size(); i++) {
			//Cell cell = cells[i];
			
			//cellsInfo +=
		}
		
		String backPackJson = String.format("\"backpack\":{\"num\":%d,\"cells\":{%s}", cell_number, cellsInfo);
		return backPackJson;
	}
}
