extends Spatial

var born_pos
var target_pos
var move_range = 20.0
var flip_h = true
export(float) var speed = 3.0

func _ready():
	born_pos  = get_translation()
	target_pos = born_pos
	flip_h = (randi() % 2) == 0
	get_node("display").set_flip_h(flip_h)
	set_process(true)
	
func _process(delta):
	var cur_pos = get_translation()
	var len = (target_pos - cur_pos).length_squared()
	if len < 0.01:
		set_target_pos(born_pos + Vector3(randf()*move_range, 0.0, randf()*move_range))
		
	move_to_target_pos(delta)

func set_target_pos(pos):
	target_pos = pos
	
func move_to_target_pos(delta):
	var cur_pos = self.get_translation()
	var dir = target_pos - cur_pos
	var len = dir.length()
	if len>0 :
		var move_len = min(delta*speed, len)
		dir = dir.normalized()
		var dest_pos = cur_pos + move_len * dir	
		if true : #terrain.is_walkable(dest_pos.x, dest_pos.z):
			self.set_translation(dest_pos)
		
			# run
	#		set_player_state(PS_MOVE, "run", false)
		else:
			set_target_pos(cur_pos)
		
	#	var camera = get_node("Camera")
	#	var screen_dir = camera.unproject_position(target_pos) - camera.unproject_position(cur_pos)
	#	if(screen_dir.x > 0):
	#		get_node("cha_man").mirror(false)
	#	elif(screen_dir.x < 0):
	#		get_node("cha_man").mirror(true)	
	#else:
	#	set_player_state(PS_IDLE, "idle", false)
