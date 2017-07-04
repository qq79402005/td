extends Spatial

export(float) var speed = 3
var current_animation = "idle"
var old_animation = ""

var target_pos = Vector3()

func _ready():
	set_process(true)
	
	target_pos = self.get_translation()
	
func _process(delta):
	#update the animation
	if current_animation!=old_animation:
		get_node("cha_man/AnimationPlayer").play(current_animation)
		old_animation = current_animation
	
	# update the pos
	var dir = Vector3(0,0,0)

	if(Input.is_action_pressed("cha_move_left")):	
		dir.x -= 1
	if(Input.is_action_pressed("cha_move_right")):	
		dir.x += 1
	if(Input.is_action_pressed("cha_move_up")):	
		dir.z -= 1
	if(Input.is_action_pressed("cha_move_down")):	
		dir.z += 1
	
	if(dir.length_squared()>0):
		dir = dir.normalized()
		dir = dir.rotated(Vector3(0,1,0), -self.get_rotation().y)
		set_target_pos(self.get_translation() + dir * speed * delta)

	move_to_target_pos(delta)
		
func move_to_target_pos(delta):
	var cur_pos = self.get_translation()
	var dir = target_pos - cur_pos
	var len = dir.length()
	if len>0 :
		var move_len = min(delta*speed, len)
		dir = dir.normalized()
		self.set_translation(cur_pos + move_len * dir)
		
		# mirror
		current_animation ="run"
		
		var camera = get_node("Camera")
		var screen_dir = camera.unproject_position(target_pos) - camera.unproject_position(cur_pos)
		if(screen_dir.x > 0):
			get_node("cha_man").mirror(false)
		elif(screen_dir.x < 0):
			get_node("cha_man").mirror(true)	
	else:
		current_animation = "idle"

func set_target_pos(target):
	target_pos = target
	
func update_terrain_display():
	
	pass