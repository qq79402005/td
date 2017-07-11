extends Node

var streamPeerTCP = null
var elapsedTime = 0

func _ready():
	streamPeerTCP = StreamPeerTCP.new()
	streamPeerTCP.connect('localhost', 8800)
	set_process(true)
	
func _process(delta):
	elapsedTime = elapsedTime + delta;	
	if streamPeerTCP.is_connected() and elapsedTime>2:	
		var login_msg = preload("res://global/protocol/login.pb.gd").new()
		login_msg.account = 6
		login_msg.password = 7	
		login_msg.send(streamPeerTCP)
		elapsedTime = 0.0
		
	var availableBytes = streamPeerTCP.get_available_bytes()
	if availableBytes > 0:
		print(streamPeerTCP.get_u8())
			#pass
			#var data = packetPeerStream.get_packet()
			#var login_msg = preload("res://global/protocol/login.pb.gd").new()
			#if login_msg.parse_data(data):		
			#	print(login_msg.account)
		
