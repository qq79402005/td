extends BTRootNode

var tick_time = 0.0
var actor = null
var born_pos
export(float) var motion_speed = 2.5
export(float) var patrol_range = 20.0
var count = 0

const state = ["BH_ERROR", "BH_SUCCESS", "BH_FAILURE", "BH_RUNNING"]
var node_list = []

func _ready():
	actor = get_parent()
	born_pos = actor.get_translation()
	
	set_process(true)

func _process(delta):
	tick_time = delta
	tick(self)
	
	update_anim()

func _bt_continue(index, context):
	pass

func _bt_prepare(index, context):
	pass

func _bt_pre_update(index, context):
	context.count += 1
	return BH_SUCCESS

func _bt_post_update(index, context, child_state):
	return child_state

func _bt_abort(index, context):
	pass

	
func get_next_random_patrol_pos():
	return born_pos + Vector3(randf() * patrol_range, 0.0, randf()*patrol_range)

#####################################
# Animation control
######################################

const	PS_IDLE = 1
const	PS_MOVE = 1
const 	PS_ATTACK = 2

var current_animation = "idle"
var old_animation = "idle"
var current_player_state = PS_IDLE

func set_anim_state(state, anim, force):
	if state >= current_player_state or force:
		current_player_state = state
		current_animation = anim
		
func update_anim():
	#update the animation
	var anim_player = actor.get_node("AnimationPlayer")
	if current_animation!=old_animation:
		anim_player.play(current_animation)
		old_animation = current_animation
	
	# 当前动画播放结束，播放休闲动画
	if not anim_player.is_playing():
		set_player_state(PS_IDLE, "idle", true)
	