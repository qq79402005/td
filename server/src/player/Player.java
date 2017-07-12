package player;

import java.util.HashMap;
import io.netty.channel.ChannelHandlerContext;

public class Player {
	public static HashMap<Integer, Player> players = new HashMap<Integer, Player>();
	public ChannelHandlerContext 		   channelCtx = null;
	
	public Player(int id, ChannelHandlerContext channelCtx) {
		this.channelCtx = channelCtx;
		
	}
	
	public static Player get(int id, ChannelHandlerContext ctx) {
		if( players.containsKey(id)) {
			return players.get(id);
		}
		else {
			Player player = new Player(id, ctx);
			players.put(id, player);
			
			return player;
		}		
	}
	
	// send info to client
	public void sendBackpackInfo(){
		protocol.backpack_num bp_num = new protocol.backpack_num();
		bp_num.num = 24;
		channelCtx.write( bp_num.data());
		
		protocol.backpack_cell bp_cell = new protocol.backpack_cell();
		bp_cell.index = 0;
		bp_cell.item_id = 1;
		bp_cell.item_num = 20;
		channelCtx.write(bp_cell.data());
	}
}
