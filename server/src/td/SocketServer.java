package td;

import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.ChannelPipeline;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import io.netty.channel.socket.SocketChannel;
import io.netty.handler.codec.string.StringDecoder;
import io.netty.handler.codec.string.StringEncoder;
import io.netty.util.CharsetUtil;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketAddress;

//import org.slf4j.Logger;

public class SocketServer {
	
	public static SocketServer inst;
	public static int port;
	
	private NioEventLoopGroup bossGroup = new NioEventLoopGroup();
	private NioEventLoopGroup workGroup = new NioEventLoopGroup();
	
	private SocketServer() {
	}
	
	public static SocketServer getInstance(){
		if(inst==null){
			inst = new SocketServer();
			inst.initData();
		}
		
		return inst;
	}
	
	private void initData(){
		port = 8700;
	}
	
	public static void main(String[] args){
		
		protocol.login login_msg = new protocol.login();
		login_msg.account = 2;
		login_msg.password = 3;
		byte[] buffer = login_msg.data();
		
		protocol.login login_msg2 = new protocol.login();
		login_msg2.parse_data(buffer);
		
		System.out.println(login_msg2.account);
		//test
		
		//SocketServer server = getInstance();
		//server.start();
	}

	public void start() {
		ServerBootstrap bootstrap = new ServerBootstrap();
		bootstrap.group(bossGroup, workGroup);
		bootstrap.channel(NioServerSocketChannel.class);
		bootstrap.option(ChannelOption.SO_BACKLOG, 128);
		bootstrap.option(ChannelOption.SO_REUSEADDR, true);
		
		bootstrap.childOption(ChannelOption.SO_KEEPALIVE, true);
		
		bootstrap.childHandler(new ChannelInitializer<SocketChannel>(){
			@Override
			protected void initChannel(SocketChannel ch) throws Exception{
				ChannelPipeline pipeline = ch.pipeline();
				pipeline.addLast(new StringDecoder(CharsetUtil.UTF_8));
				pipeline.addLast(new StringEncoder(CharsetUtil.UTF_8));
				pipeline.addLast(new DiscardServerHandler());
			}
		});
		
		// start server
		ChannelFuture future;
		try{
			future = bootstrap.bind(port).sync();
			if(future.isSuccess()){
				System.out.println("bind port 8700 succeed");
			}
		}
		catch(InterruptedException e){
			System.out.println("bind port failed");
		}
	}
	
	
	public void shut(){
		workGroup.shutdownGracefully();
		bossGroup.shutdownGracefully();
		
		//ChannelMgr.getInstance().closeAllChannel();
	}
}
