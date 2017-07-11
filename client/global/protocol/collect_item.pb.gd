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
	var buf = ByteBuf()
	buf.write_int32(int(id()))
	buf.write_int32(int(length()))
	buf.write_int32(count)
	buf.write_int32(type)
	buf.write_int32(id)
	stream.put_data(buf.raw_data())
