package td;

import io.netty.buffer.ByteBuf;

import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.util.ReferenceCountUtil;

public class DiscardServerHandler extends ChannelInboundHandlerAdapter {
	
	@Override
	public void channelRead(ChannelHandlerContext ctx, Object msg){
		try{
			/*ByteBuf in = (ByteBuf)msg;
			while(in.isReadable()){
				System.out.print((char)in.readByte());
				System.out.flush();
			}*/
			System.out.println(msg.toString());
			System.out.println("Received msg form ip ");
		} finally{
			ReferenceCountUtil.release(msg);
		}
	}
	
	@Override
	public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause){
		// Close the connection when an exception is raised
		cause.printStackTrace();
		ctx.close();
	}
}
