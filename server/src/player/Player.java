package player;

import db.db;
import java.util.HashMap;
import io.netty.channel.ChannelHandlerContext;

public class Player {
	public static HashMap<Integer, Player> players = new HashMap<Integer, Player>();
	public ChannelHandlerContext 		   channelCtx = null;
	protected String 					   account;
	protected String					   name;			// player name
	protected String					   json = "{}";			// info in json format
	protected Backpack					   backpack = null;
	
	public Player(ChannelHandlerContext channelCtx) {
		this.channelCtx = channelCtx;
		
	}
	
	public static Player get(ChannelHandlerContext ctx) {
		int ctxID = ctx.hashCode();
		if( players.containsKey(ctxID)) {
			return players.get(ctxID);
		}
		else {
			Player player = new Player(ctx);
			players.put(ctxID, player);
			
			return player;
		}		
	}
	
	public void setAccount(String account, String name) {
		// load player data from db
		this.account = account;
		this.name = name;
		this.backpack = new Backpack();
		//this.backpack.init(account);
		
		// disconned same account
		if(!db.instance().isPlayerExist(name)) {
			refreshPlayerToJson();
			db.instance().saveNewPlayer(this.account, name, this.json);
		}
	}
	
	protected void refreshPlayerToJson() {
		
		String backPackJson = String.format("\"backpack\":{\"num\":%d}", backpack.cell_number);
		
		json = String.format(
				"{" +
					backPackJson +
				"}");
	}
	
	public void saveToDB() {
		db.instance().savePlayer(this);
	}
	
	public void collectItem(int id, int count, int type) {
		// add to bag
		
		// send to client
		protocol.backpack_cell bp_cell = new protocol.backpack_cell();
		bp_cell.index = 0;
		bp_cell.item_id = 1;
		bp_cell.item_num = 15;
		channelCtx.write(bp_cell.data());
	}
	
	// send info to client
	public void sendBackpackInfo(){
		protocol.backpack_num bp_num = new protocol.backpack_num();
		bp_num.num = backpack.cell_number;
		channelCtx.write( bp_num.data());
		
		protocol.backpack_cell bp_cell = new protocol.backpack_cell();
		bp_cell.index = 0;
		bp_cell.item_id = 1;
		bp_cell.item_num = 15;
		channelCtx.write(bp_cell.data());
	}
}
