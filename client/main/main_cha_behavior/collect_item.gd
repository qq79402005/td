extends BTActionNode

export(int, "BH_ERROR", "BH_SUCCESS", "BH_FAILURE", "BH_RUNNING") var update_result = 0

func _bt_update(index, context):
	var target_item = context.actor.target_item
	if target_item != null:
		get_node("/root/network").collect_item(target_item.get_id())
		target_item.get_parent().get_parent().remove_child(target_item.get_parent())
		context.actor.target_item = null
		return 1
	else:
		return 2
