extends BTDecoratorNode

var elapsed_time = 0.0

export(int, "BH_ERROR", "BH_SUCCESS", "BH_FAILURE", "BH_RUNNING") var update_result = 0

func _bt_pre_update(index, context):
	elapsed_time += context.tick_time
	if elapsed_time > 0.0 and elapsed_time < 20.0:
		return 1
	elif elapsed_time > 30.0:
		elapsed_time = 0.0
		
	return 2
