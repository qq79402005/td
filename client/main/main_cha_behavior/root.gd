extends BTRootNode

var tick_time = 0.0
var actor = null
export(float) var motion_speed = 2.5
export(float) var patrol_range = 20.0

const state = ["BH_ERROR", "BH_SUCCESS", "BH_FAILURE", "BH_RUNNING"]

func _ready():
	actor = get_parent()
	set_process(true)
	set_process_input(true)

func _process(delta):
	tick_time = delta
	tick(self)
	update_anim()

func _input(event):
	if(event.is_action_pressed("skill_0")):
		set_anim_state(PS_ATTACK, "attack", false)

func _bt_continue(index, context):
	pass

func _bt_prepare(index, context):
	pass

func _bt_pre_update(index, context):
	return BH_SUCCESS

func _bt_post_update(index, context, child_state):
	return child_state

func _bt_abort(index, context):
	pass

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
	var anim_player = actor.get_node("cha_man/AnimationPlayer")
	if current_animation!=old_animation:
		anim_player.play(current_animation)
		old_animation = current_animation
	
	# 当前动画播放结束，播放休闲动画
	if not anim_player.is_playing():
		set_anim_state(PS_IDLE, "idle", true)
	