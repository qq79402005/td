extends Node

var type = int(0)

func _ready():
	pass

func name():
	return 'resurgence'
func id():
	return 11

func length():
	return 4

func send(stream):
	var buf = ByteBuf.new()
	buf.write_i32(int(id()))
	buf.write_i32(int(length()))
	buf.write_i32(type)
	buf.write_byte(64)
	buf.write_byte(64)
	stream.put_data(buf.raw_data())

func parse_data( byteBuffer):
	type = byteBuffer.read_i32();
