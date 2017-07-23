extends BTActionNode

export(int, "BH_ERROR", "BH_SUCCESS", "BH_FAILURE", "BH_RUNNING") var update_result = 0

func _bt_update(index, context):
	context.set_anim_state(context.PS_IDLE, "idle", false)	
	return 1

