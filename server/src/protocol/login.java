package protocol;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;

public class login extends message {

	public int account = 0;
	public int password = 0;
	@Override

	public int id(){
		 return 8;
	}

	@Override
	public int length(){
		 return 8;
	}

	public ByteBuf data(){
		ByteBuf byteBuffer = Unpooled.buffer(8+length());
		byteBuffer.writeInt(id());
		byteBuffer.writeInt(length());
		byteBuffer.writeInt(account);
		byteBuffer.writeInt(password);
		byteBuffer.writeByte(64);
		byteBuffer.writeByte(64);
		return byteBuffer;
	}

	@Override
	public void parse_data(ByteBuf byteBuffer){
		account = byteBuffer.readInt();
		password = byteBuffer.readInt();
	}
}
