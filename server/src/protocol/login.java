package protocol;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;

public class login {

	public int account = 0;
	public int password = 0;

	public int id(){
		 return 2;
	}

	public int length(){
		 return 8;
	}

	public ByteBuf data(){
		ByteBuf byteBuffer = Unpooled.buffer(8+length());
		byteBuffer.writeInt(id());
		byteBuffer.writeInt(length());
		byteBuffer.writeInt(account);
		byteBuffer.writeInt(password);
		return byteBuffer;
	}

	public boolean parse_data(ByteBuf byteBuffer){
		int msg_id = byteBuffer.readInt();
		int msg_length = byteBuffer.readInt();
		if(msg_id==id() && msg_length==length()){
			account = byteBuffer.readInt();
			password = byteBuffer.readInt();
			return true;
		}
		else {
			return false;
		}
	}
}
