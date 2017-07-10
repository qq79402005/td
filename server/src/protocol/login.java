package protocol;

import java.nio.ByteBuffer;

public class login {

	public int account = 0;
	public int password = 0;

	public int id(){
		 return 2;
	}

	public int length(){
		 return 8;
	}

	public byte[] data(){
		ByteBuffer byteBuffer = ByteBuffer.allocate(8+length());
		byteBuffer.putInt(id());
		byteBuffer.putInt(length());
		byteBuffer.putInt(account);
		byteBuffer.putInt(password);
		return byteBuffer.array();
	}

	public boolean parse_data(byte[] byteArray){
		ByteBuffer byteBuffer = ByteBuffer.wrap(byteArray);
		int msg_id = byteBuffer.getInt();
		int msg_length = byteBuffer.getInt();
		if(msg_id==id() && msg_length==length()){
			account = byteBuffer.getInt();
			password = byteBuffer.getInt();
			return true;
		}
		else {
			return false;
		}
	}
}
