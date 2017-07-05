extends Node2D

var cur_weather = 0   # normal
var elapsed_time = 0

func _ready():
	set_process(true)

func _process(delta):
	elapsed_time += delta;
	if(elapsed_time > 3.0):
		get_node("snow").set_hidden(false)
		
	#if(elapsed_time>20.0):
		#hide_all()
		#elapsed_time = 0.0

func hide_all():
	get_node("snow").set_hidden(true)