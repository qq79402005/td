extends Spatial

var blood = 50.0

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
	target_pos = target

func is_dead():
	if blood <= 0.0:
		return true
	else:
		return false
	
func on_attack(damage):
	blood = max(blood-damage, 0)
	get_node("/root/level/ui/head_blood/blood").set_value(blood)
	#if blood == 0:
	#	set_player_state(PS_DIE, "die", true)
	