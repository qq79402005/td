extends Node2D

var cur_weather = 0   # normal
var elapsed_time = 0

var lightness = -1
var daynight_phase = 0
var daynight_phase_time = 0
var daynight_time  = [5, 3, 5, 3]
var daynight_color = [Color(1.0,1.0,1.0), Color(1.0,1.0,1.0),Color(1.0,1.0,1.0), Color(0.0,0.0,0.0),Color(0.0,0.0,0.0), Color(0.0,0.0,0.0),Color(0.0,0.0,0.0), Color(1.0,1.0,1.0)]

func _ready():
	set_process(true)

func _process(delta):
	elapsed_time += delta;
	#if(elapsed_time > 3.0):
	#	get_node("snow").set_hidden(false)
		
	#if(elapsed_time>20.0):
	#	hide_all()
	#	elapsed_time = 0.0	
	daynight_update(delta)

func hide_all():
	get_node("snow").set_hidden(true)
	
func daynight_update(delta):
	daynight_phase_time += delta
	if daynight_phase_time > daynight_time[daynight_phase]:
		daynight_phase = (daynight_phase + 1) % 4
		daynight_phase_time = 0.0
		print(daynight_phase)
	
	var beginColor = daynight_color[daynight_phase*2]
	var endColor = daynight_color[daynight_phase*2+1]
	var ratio = daynight_phase_time / daynight_time[daynight_phase]
	var color =  beginColor.linear_interpolate(endColor, ratio)
	get_tree().get_root().get_node("level/terrain/DirectionalLight").set_color(0, color)