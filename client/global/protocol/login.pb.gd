extends Node

var account = int(0)
var password = int(0)

func _ready():
	pass

func id():
	return 2

func length():
	return 8

func send(stream):
	var buf = ByteBuf.new()
	buf.resize(8+length())
	buf.write_i32(int(id()))
	buf.write_i32(int(length()))
	buf.write_i32(account)
	buf.write_i32(password)
	stream.put_data(buf.raw_data())

func parse_data( byteBuffer):
	var msg_id = byteBuffer.read_i32();
	var msg_length = byteBuffer.read_i32();
	if msg_id==id() and msg_length==length():
		account = byteBuffer.read_i32();
		password = byteBuffer.read_i32();
		return true;
	else:
		return false;
