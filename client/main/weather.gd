extends Node2D

var role_node = null	# main character node
var elapsedTime = 0.0

var cur_weather = 0   # normal

var lastGameTime = 0
var daynight_phase = 0
var daynight_phase_time = 0
var daynight_total_time = 0
export(IntArray) var daynight_time  = [2600, 3, 904, 3]
var daynight_color = [Color(1.0,1.0,1.0), Color(1.0,1.0,1.0),Color(1.0,1.0,1.0), Color(0.0,0.0,0.0),Color(0.0,0.0,0.0), Color(0.0,0.0,0.0),Color(0.0,0.0,0.0), Color(1.0,1.0,1.0)]

func _ready():
	role_node = Globals.get("main_character")
	
	for i in range(daynight_time.size()):
		daynight_total_time += daynight_time[i]
	
	set_process(true)

func _process(delta):
	elapsedTime += delta;
	if elapsedTime>5.0:
		get_node("/root/network").addGameTime(5.0)
		elapsedTime -= 5.0
	
	#if(elapsed_time > 3.0):
	#	get_node("snow").set_hidden(false)
		
	rain_update()
	daynight_update(delta)

func hide_all():
	get_node("snow").set_hidden(true)
	
func daynight_update(delta):
	var gameTime = get_node("/root/global").gameTime
	if lastGameTime!=gameTime:
		var day      = gameTime / 3600
		var dayTime  = int(gameTime) % daynight_total_time
		daynight_phase = 0
		for i in range(daynight_time.size()):
			if dayTime > daynight_time[i]:
				dayTime -= daynight_time[i]
				daynight_phase = (i + 1) % daynight_time.size()
			else:
				break
						
		daynight_phase_time = dayTime
		lastGameTime = gameTime
	
	var beginColor = daynight_color[daynight_phase*2]
	var endColor = daynight_color[daynight_phase*2+1]
	var ratio = daynight_phase_time / daynight_time[daynight_phase]
	var color =  beginColor.linear_interpolate(endColor, ratio)
	get_node("/root/level/environment/WorldEnvironment").get_environment().fx_set_param(Environment.FX_PARAM_AMBIENT_LIGHT_COLOR, color)
	
func rain_update():
	var role_pos = role_node.get_translation()
	role_pos.y += 5.0
	get_node("rain").set_translation(role_pos)