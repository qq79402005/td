extends Node

var count = int(0)
var type = int(0)
var id = int(0)

func _ready():
	pass

func id():
	return 1

func length():
	return 12

func send(stream):
	var buf = ByteBuf.new()
	buf.resize(8+length())
	buf.write_i32(int(id()))
	buf.write_i32(int(length()))
	buf.write_i32(count)
	buf.write_i32(type)
	buf.write_i32(id)
	stream.put_data(buf.raw_data())

func parse_data( byteBuffer):
	var msg_id = byteBuffer.read_i32();
	var msg_length = byteBuffer.read_i32();
	if msg_id==id() and msg_length==length():
		count = byteBuffer.read_i32();
		type = byteBuffer.read_i32();
		id = byteBuffer.read_i32();
		return true;
	else:
		return false;
