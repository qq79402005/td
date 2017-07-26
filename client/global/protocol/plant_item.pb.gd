extends Node

var pos_z = float(0)
var pos_x = float(0)
var pos_y = float(0)
var slot_idx = int(0)

func _ready():
	pass

func name():
	return 'plant_item'
func id():
	return 10

func length():
	return 16

func send(stream):
	var buf = ByteBuf.new()
	buf.write_i32(int(id()))
	buf.write_i32(int(length()))
	buf.write_float(pos_z)
	buf.write_float(pos_x)
	buf.write_float(pos_y)
	buf.write_i32(slot_idx)
	buf.write_byte(64)
	buf.write_byte(64)
	stream.put_data(buf.raw_data())

func parse_data( byteBuffer):
	pos_z = byteBuffer.read_float();
	pos_x = byteBuffer.read_float();
	pos_y = byteBuffer.read_float();
	slot_idx = byteBuffer.read_i32();
