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
	buf.write_int32(int(id()))
	buf.write_int32(int(length()))
	buf.write_int32(account)
	buf.write_int32(password)
	stream.put_data(buf.raw_data())


