package protocol;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;

public class collect_item {

	public int count = 0;
	public int type = 0;
	public int id = 0;

	public int id(){
		 return 1;
	}

	public int length(){
		 return 12;
	}

	public ByteBuf data(){
		ByteBuf byteBuffer = Unpooled.buffer(8+length());
		byteBuffer.writeInt(id());
		byteBuffer.writeInt(length());
		byteBuffer.writeInt(count);
		byteBuffer.writeInt(type);
		byteBuffer.writeInt(id);
		return byteBuffer;
	}

	public boolean parse_data(ByteBuf byteBuffer){
		int msg_id = byteBuffer.readInt();
		int msg_length = byteBuffer.readInt();
		if(msg_id==id() && msg_length==length()){
			count = byteBuffer.readInt();
			type = byteBuffer.readInt();
			id = byteBuffer.readInt();
			return true;
		}
		else {
			return false;
		}
	}
}
