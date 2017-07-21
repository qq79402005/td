extends BTActionNode
var isInit = false
var elapsed_time = 0.0
export(float) var skill_length = 0.8
export(float) var skill_prepare_time = 8.0
var jump_pos
var target_pos

export(int, "BH_ERROR", "BH_SUCCESS", "BH_FAILURE", "BH_RUNNING") var update_result = 0

func _bt_continue(index, context):
	pass

func _bt_prepare(index, context):
	var main_character = Globals.get("main_character")
	target_pos = main_character.get_translation()
	jump_pos = context.actor.get_translation()
	context.actor.show_acctack_target( target_pos,true)
	elapsed_time = -skill_prepare_time

func _bt_update(index, context):
	var last_elapsed_time = elapsed_time	
	elapsed_time += context.tick_time
	
	if last_elapsed_time<=0.0 and elapsed_time>0.0:
		context.set_anim_state(context.PS_ATTACK, "attack", false)
	
	var cur_pos = jump_pos. linear_interpolate(target_pos, clamp( elapsed_time / skill_length, 0.0, 1.0))
	context.actor.set_translation(cur_pos)
	
	if elapsed_time < skill_length:
		return 3
	else:
		context.actor.show_acctack_target( target_pos,false)
		return 1