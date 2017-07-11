extends Node

var streamPeerTCP = null
var elapsedTime = 0

var msg_bind = []
var end_flag = 64
var last_byte = 0
var cur_package = ByteBuf.new()

func _ready():
	bind_msgs()
	streamPeerTCP = StreamPeerTCP.new()
	streamPeerTCP.connect('localhost', 8800)
	set_process(true)
	
func _process(delta):
	elapsedTime = elapsedTime + delta;	
	if streamPeerTCP.is_connected() and elapsedTime>2:	
		var login_msg = preload("res://global/protocol/login.pb.gd").new()
		login_msg.account = 45678
		login_msg.password = 9
		login_msg.send(streamPeerTCP)
		elapsedTime = 0.0
		
	# parse msg	
	var availableBytes = streamPeerTCP.get_available_bytes()
	while availableBytes > 0:
		process_net_byte(streamPeerTCP.get_u8())
		availableBytes = streamPeerTCP.get_available_bytes()
	
func bind( msg):
	var msgInst = msg.new()
	var id  = msgInst.id()
	var fun_cb = funcref(self, "on_msg_%s" % msgInst.name())
	if id+1 > msg_bind.size():
		msg_bind.resize(id+1)
		 
	msg_bind[id] = [msgInst, fun_cb]
		
func process_net_byte(byte):
	if last_byte!=end_flag and byte!=end_flag:
		cur_package.write_byte(byte)
		last_byte = byte
	elif last_byte==end_flag and byte==end_flag:
		process_net_package(cur_package)
		cur_package = ByteBuf.new()
		last_byte = 0
	elif last_byte==end_flag and byte!=end_flag:
		cur_package.write_byte(last_byte)
		cur_package.write_byte(byte)
		last_byte = byte
	else:	
		last_byte = byte
	
func process_net_package(buf):
	var msg_id = buf.read_i32()
	var msg_length = buf.read_i32()
	var msg = msg_bind[msg_id][0]
	var msg_cb = msg_bind[msg_id][1]	
	msg.parse_data(buf)
	msg_cb.call_func(msg)

func bind_msgs():
	bind(preload("res://global/protocol/login.pb.gd"))
	bind(preload("res://global/protocol/collect_item.pb.gd"))
		
func on_msg_login( msg):
	print(msg.account)
	
func on_msg_collect_item(msg):
	print("collect_item")
	print(msg.type)