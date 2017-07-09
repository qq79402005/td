package td;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketAddress;

public class SocketServer {
	
	public static void main(String[] args){
		run();
	}

	public static void run() {
		int servPort = 8888;
		ServerSocket servSocket = null;
		int recvMsgSize = 0;
		
		byte[] receivBuf = new byte[32];
		try{
			servSocket = new ServerSocket(servPort);
			
			while(true){
				System.out.println("server start port:" + servPort);
				
				Socket clientSocket = servSocket.accept();
				SocketAddress clientAddress = clientSocket.getRemoteSocketAddress();
				System.out.println("accept connect from ip:" + clientAddress);
				
				InputStream in = clientSocket.getInputStream();
				OutputStream out = clientSocket.getOutputStream();
				while((recvMsgSize = in.read(receivBuf))!=-1){
					String receivedData = new String(receivBuf.toString());
					System.out.println(receivedData);
					out.write(receivBuf, 0, recvMsgSize);
				}
				
				clientSocket.close();
			}	
		} catch(IOException e){	
			e.printStackTrace();
		}
		
	}
}
