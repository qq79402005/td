extends BTActionNode

export(int, "BH_ERROR", "BH_SUCCESS", "BH_FAILURE", "BH_RUNNING") var update_result = 0

func _bt_update(index, context):
	var target_pos = context.actor.target_pos
	var cur_pos = context.actor.get_translation()
	if target_pos != cur_pos:
			return 1
		
	return 2
	
