package net;

import java.util.HashMap;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.util.ReferenceCountUtil;


class ProtocolInfo{
	public int				id;
	public protocol.message protocol;
	public ProtocolProcess	process;
	
	public ProtocolInfo(int _id, protocol.message msg, ProtocolProcess process){
		id = _id;
		protocol = msg;
		this.process = process;
	}
}

public class SocketServerHandler extends ChannelInboundHandlerAdapter {
	
	public static HashMap<Integer, ProtocolInfo> protocols = new HashMap<Integer, ProtocolInfo>();
	
	public SocketServerHandler() {
		bindProtocols();
	}
	
	@Override
	public void channelRead(ChannelHandlerContext ctx, Object msg){
		try{	
			ByteBuf buff = (ByteBuf)msg;
			while(buff.isReadable()){
				int id = buff.readInt();
				int len = buff.readInt();
				if( protocols.containsKey(id)) {
					ProtocolInfo protoInfo = protocols.get( id);
					if(len == protoInfo.protocol.length()) {
						protoInfo.protocol.parse_data(buff);
						protoInfo.process.on_accept( protoInfo.protocol, ctx);
					}
				}
			}
		} finally{
			ReferenceCountUtil.release(msg);
		}
	}
	
	@Override
	public void channelReadComplete(ChannelHandlerContext ctx) {
		ctx.flush();
	}
	
	@Override
	public void channelInactive(ChannelHandlerContext ctx)throws Exception {
		// channelʧЧ�쳣���ͻ������߻���ǿ���˳��ȴ�����
		player.Player.disconnectPlayer(ctx);
		
		//super.channelInactive(ctx);
	}
	
	@Override
	public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause){
		// Close the connection when an exception is raised
		cause.printStackTrace();
		ctx.close();
	}
	
	public static void bindProtocols()
	{
		ProtocolProcess.bind();
	}
	
	public static void bind(protocol.message msg, ProtocolProcess func)
	{
		ProtocolInfo info = new ProtocolInfo(msg.id(), msg, func);	
		protocols.put(msg.id(), info);
	}
}
