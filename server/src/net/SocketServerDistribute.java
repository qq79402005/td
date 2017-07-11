package net;

import java.util.HashMap;

public class SocketServerDistribute {
	
	public HashMap<Integer, protocol.message> bind_msgs = new HashMap<Integer, protocol.message>();
	
	public void bind_msgs()
	{
		bind(new protocol.login());
		bind(new protocol.collect_item());
	}
	
	public void bind(protocol.message msg)
	{
		bind_msgs.put(msg.id(), msg);
	}
}
