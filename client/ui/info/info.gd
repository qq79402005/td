extends Panel

var lastGameTime = 0

func _ready():
	set_process(true)

func _process(delta):
	var gameTime = get_node("/root/global").gameTime
	if lastGameTime!=gameTime:
		var day      = gameTime / 3600
		get_node("time").set_text(String("Day:") + String(day))
	
		var process  = (int(gameTime) % 3600) / 3600.0
		process *= 100.0
		get_node("process").set_value(int(process))
		
		lastGameTime = gameTime
