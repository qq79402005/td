extends Node

var streamPeerTCP = null
var elapsedTime = 0

func _ready():
	streamPeerTCP = StreamPeerTCP.new()
	streamPeerTCP.connect('localhost', 8800)
	set_process(true)
	
func _process(delta):
	elapsedTime = elapsedTime + delta;	
	if streamPeerTCP.is_connected() and elapsedTime>5:	
		var login_msg = preload("res://global/protocol/login.pb.gd").new()
		login_msg.account = 1
		login_msg.password = 2	
		login_msg.send(streamPeerTCP)
	
		elapsedTime = 0.0
		
		var availablePacketCount = packetPeerStream.get_available_packet_count()
		if availablePacketCount > 0:
			var data = packetPeerStream.get_packet()
			var login_msg = preload("res://global/protocol/login.pb.gd").new()
			if login_msg.parse_data(data):		
				print(login_msg.account)
		
