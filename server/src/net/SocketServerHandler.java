package net;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.util.ReferenceCountUtil;

public class SocketServerHandler extends ChannelInboundHandlerAdapter {
	
	@Override
	public void channelRead(ChannelHandlerContext ctx, Object msg){
		try{	
			ByteBuf buff = (ByteBuf)msg;
			/*while(buff.isReadable()){				
				protocol.login login_msg = new protocol.login();
				if(login_msg.parse_data(buff)) {
					System.out.println("parse login_msg succeed");
				}
			}*/
			ByteBuf resp = Unpooled.copiedBuffer(buff);
			ctx.write(resp);
		} finally{
			ReferenceCountUtil.release(msg);
		}
	}
	
	@Override
	public void channelReadComplete(ChannelHandlerContext ctx) {
		ctx.flush();
	}
	
	@Override
	public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause){
		// Close the connection when an exception is raised
		cause.printStackTrace();
		ctx.close();
	}
}
