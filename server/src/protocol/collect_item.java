package protocol;

import java.nio.ByteBuffer;

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

	public byte[] data(){
		ByteBuffer byteBuffer = ByteBuffer.allocate(8+length());
		byteBuffer.putInt(id());
		byteBuffer.putInt(length());
		byteBuffer.putInt(count);
		byteBuffer.putInt(type);
		byteBuffer.putInt(id);
		return byteBuffer.array();
	}

	public boolean parse_data(byte[] byteArray){
		ByteBuffer byteBuffer = ByteBuffer.wrap(byteArray);
		int msg_id = byteBuffer.getInt();
		int msg_length = byteBuffer.getInt();
		if(msg_id==id() && msg_length==length()){
			count = byteBuffer.getInt();
			type = byteBuffer.getInt();
			id = byteBuffer.getInt();
			return true;
		}
		else {
			return false;
		}
	}
}
