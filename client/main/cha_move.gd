extends Spatial


const	PS_IDLE = 1
const	PS_MOVE = 1
const 	PS_ATTACK = 2

export(float) var speed = 3
var current_animation = "idle"
var old_animation = "idle"
var current_player_state = PS_IDLE

var target_pos = Vector3()

func _ready():
	set_process(true)
	set_process_input(true)
	
	target_pos = self.get_translation()
	
func _process(delta):
	#update the animation
	var anim_player = get_node("cha_man/AnimationPlayer")
	if current_animation!=old_animation:
		anim_player.play(current_animation)
		old_animation = current_animation
	
	# 当前动画播放结束，播放休闲动画
	if not anim_player.is_playing():
		set_player_state(PS_IDLE, "idle", true)
	
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
	
	if(dir.length_squared()>0 and current_player_state!=PS_ATTACK):
		dir = dir.normalized()
		dir = dir.rotated(Vector3(0,1,0), -self.get_rotation().y)
		set_target_pos(self.get_translation() + dir * speed * delta)

	move_to_target_pos(delta)
	
func _input(event):
	if(event.is_action_pressed("skill_0")):
		set_player_state(PS_ATTACK, "attack", false)
		
func move_to_target_pos(delta):
	var cur_pos = self.get_translation()
	var dir = target_pos - cur_pos
	var len = dir.length()
	if len>0 :
		var move_len = min(delta*speed, len)
		dir = dir.normalized()
		var dest_pos = cur_pos + move_len * dir	
		self.set_translation(dest_pos)
		
		# mirror
		set_player_state(PS_MOVE, "run", false)
		
		var camera = get_node("Camera")
		var screen_dir = camera.unproject_position(target_pos) - camera.unproject_position(cur_pos)
		if(screen_dir.x > 0):
			get_node("cha_man").mirror(false)
		elif(screen_dir.x < 0):
			get_node("cha_man").mirror(true)	
	else:
		set_player_state(PS_IDLE, "idle", false)
		
func set_player_state(state, anim, force):
	if state >= current_player_state or force:
		current_player_state = state
		current_animation = anim
		
		if(state==PS_ATTACK):
			set_target_pos(self.get_translation())

func set_target_pos(target):
	target_pos = target