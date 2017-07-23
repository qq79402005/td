extends BTActionNode

var collect_time = 0.8
export(int, "BH_ERROR", "BH_SUCCESS", "BH_FAILURE", "BH_RUNNING") var update_result = 0

func _bt_prepare(index, context):
	collect_time = 0.8

func _bt_update(index, context):
	var target_item = context.actor.target_item
	if target_item != null:
		if collect_time > 0.0 :
			collect_time -= context.tick_time
			context.set_anim_state(context.PS_ATTACK, "collect", false)	
			return 3
		else:
			get_node("/root/network").collect_item(target_item.get_id())
			target_item.get_parent().queue_free()
			context.actor.target_item = null
			return 1
	else:
		return 2
