extends Spatial

var cur_blood = 50.0
var max_blood = 100.0

var terrain = null
var target_pos = Vector3()
var target_item = null

func _ready():
	terrain = get_tree().get_root().get_node("level/terrain")	
	Globals.set("main_character", self)
	
	set_process(true)
	
	target_pos = self.get_translation()
	
func _process(delta):
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
	
	if dir.length_squared()>0 :#and current_player_state!=PS_ATTACK):
		dir = dir.normalized()
		dir = dir.rotated(Vector3(0,1,0), -self.get_rotation().y)
		var speed = get_node("behavior").motion_speed
		set_target_pos(self.get_translation() + dir * speed * delta)
		
func set_target_pos(target):
	if cur_blood > 0.0:
		target_pos = target
	
func set_blood_info( curBlood, maxBlood):
	cur_blood = curBlood;
	max_blood = maxBlood;
	var blood = float(cur_blood) / float(max_blood) * 100.0
	get_node("/root/level/ui/head_blood/blood").set_value(blood)
	
	if cur_blood <=0:
		get_node("/root/level/ui/resurrection").set_hidden(false)
		#set_player_state(PS_DIE, "die", true)
	else:
		get_node("/root/level/ui/resurrection").set_hidden(true)
		#set_player_state(PS_DIE, "die", true)

func is_dead():
	if cur_blood <= 0.0:
		return true
	else:
		return false
	
func on_attack(damage):
	get_node("/root/network").on_attacked(damage)
	