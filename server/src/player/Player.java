package player;

import db.db;
import java.util.HashMap;
import java.util.Iterator;
import io.netty.channel.ChannelHandlerContext;
import com.google.gson.Gson;
import java.util.Timer;

class Info{
	protected Backpack					   	backpack = null;
	protected Building						building = null;
	protected Currency						currency = null;
	
	public Info() {
		backpack = new Backpack();
		building = new Building();
		currency = new Currency();
	}
}

public class Player {
	public static HashMap<Integer, Player>  players = new HashMap<Integer, Player>();
	public ChannelHandlerContext 		   	mChannelCtx = null;
	protected String 					   	mAccount;
	protected String					   	mName;			// player name
	protected String					   	mJsonData = "{}";			// info in json format
	protected Info					   		mInfo = new Info();
	
	public Player(ChannelHandlerContext channelCtx) {
		mChannelCtx = channelCtx;		
	}
	
	public static void update() {
		for(Player player : players.values()) {
			player.saveToDB();
		}
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
		// load player data from database
		this.mAccount = account;
		this.mName = name;
		
		// disconnect same account
		if(!db.instance().isPlayerExist(name)) {
			refreshPlayerToJson();
			db.instance().saveNewPlayer(this.mAccount, name, this.mJsonData);
		}else {
			// disconnect same name player
			disconnectPlayer(mName);
			
			// init this player
			loadFromDB();
		}
	}
	
	protected void disconnectPlayer(String name) {
		for(HashMap.Entry<Integer, Player> entry : players.entrySet()) {
			Player player = entry.getValue();
			if (player.mName==name) {
				player.saveToDB();
				player.mChannelCtx.disconnect();
				
				players.remove(entry.getKey());
				
				break;
			}
		}
	}
	
	protected boolean refreshPlayerToJson() {
		Gson gson = new Gson();
		String new_json = gson.toJson(mInfo);	
		if(mJsonData!=new_json)
		{
			mJsonData = new_json;
			
			return true;
		}
			
		return false;
	}
	
	public void saveToDB() {
		if(refreshPlayerToJson()) {
			db.instance().savePlayer(mAccount, mName, mJsonData);
			System.out.println(String.format("account [%s] player [%s] save to db", mAccount,mName));
		}
	}
	
	public void loadFromDB() {
		Gson gson = new Gson();
		mJsonData = db.instance().getPlayerInfo( mAccount, mName);
		mInfo = gson.fromJson( mJsonData, Info.class);
	}
	
	public void collectItem(int id, int count, int type) {
		// add to bag
		
		// send to client
		protocol.backpack_cell bp_cell = new protocol.backpack_cell();
		bp_cell.index = 0;
		bp_cell.item_id = 1;
		bp_cell.item_num = 15;
		mChannelCtx.write(bp_cell.data());
	}
	
	// send info to client
	public void sendBackpackInfo(){
		protocol.backpack_num bp_num = new protocol.backpack_num();
		bp_num.num = mInfo.backpack.cell_number;
		mChannelCtx.write( bp_num.data());
		
		protocol.backpack_cell bp_cell = new protocol.backpack_cell();
		bp_cell.index = 0;
		bp_cell.item_id = 1;
		bp_cell.item_num = 15;
		mChannelCtx.write(bp_cell.data());
	}
}
