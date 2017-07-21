extends BTActionNode

export(float) var idle_time
var elapsed_time
export(int, "BH_ERROR", "BH_SUCCESS", "BH_FAILURE", "BH_RUNNING") var update_result = 0

func _bt_continue(index, context):
	pass

func _bt_prepare(index, context):
	elapsed_time = idle_time

func _bt_update(index, context):
	if elapsed_time > 0:
		context.set_anim_state(context.PS_IDLE, "idle", false)
		elapsed_time = elapsed_time - context.tick_time
		update_result = 3
	else:
		update_result = 1
		
	return update_result

func _bt_abort(index, context):
	pass
