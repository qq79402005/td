package net;

import io.netty.channel.ChannelHandlerContext;
import player.Player;

interface ProtocolProcess {
	public void on_accept(protocol.message proto, ChannelHandlerContext ctx);
	
	public static void bind() {
		SocketServerHandler.bind(new protocol.login(), new login_process());
		SocketServerHandler.bind(new protocol.collect_item(), new collect_item_process());
	}
}

class login_process implements ProtocolProcess{
	@Override
	public void on_accept(protocol.message proto, ChannelHandlerContext ctx) {
		protocol.login msg = (protocol.login)proto;		
		Player player = Player.get(ctx);
		player.setAccount("qq79402005", "aqi");
		player.sendBackpackInfo();
	}
}

class collect_item_process implements ProtocolProcess{
	@Override
	public void on_accept(protocol.message proto, ChannelHandlerContext ctx) {
		protocol.collect_item msg = (protocol.collect_item)proto;
		
		Player player = Player.get(ctx);
		player.collectItem(msg.id, msg.count, msg.type);
	}
}