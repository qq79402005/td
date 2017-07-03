extends Spatial

var speed = 3
var current_animation = "idle"
var old_animation = ""

func _ready():
	set_process(true)
	
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
		current_animation ="run"
		dir = dir.normalized()
		var curPos = self.get_translation() + dir * speed * delta;
		self.set_translation(curPos)
		
		# mirror
		if(dir.x > 0):
			get_node("cha_man").mirror(false)
		elif(dir.x < 0):
			get_node("cha_man").mirror(true)
	else :
		current_animation = "idle"
		
