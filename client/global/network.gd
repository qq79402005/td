extends Node

var streamPeerTCP = null
var elapsedTime = 0

func _ready():
	streamPeerTCP = StreamPeerTCP.new()
	streamPeerTCP.connect('localhost', 8700)
	
	set_process(true)
	
func _process(delta):
	elapsedTime = elapsedTime + delta;	
	if streamPeerTCP.is_connected() and elapsedTime>2:
		streamPeerTCP.put_var('hello, I am godot engine')
		elapsedTime = 0.0
		
		var availableByte = streamPeerTCP.get_available_bytes()
		if availableByte > 0:
			var data = streamPeerTCP.get_data(availableByte)
			print(data)
		
