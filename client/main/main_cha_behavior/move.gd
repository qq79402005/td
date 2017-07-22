extends BTActionNode

export(int, "BH_ERROR", "BH_SUCCESS", "BH_FAILURE", "BH_RUNNING") var update_result = 0

func _bt_continue(index, context):
	pass

func _bt_prepare(index, context):
	pass

func _bt_update(index, context):
	update_result = move_to_target_pos( context.tick_time, context)
	return update_result

func _bt_abort(index, context):
	pass
	
func move_to_target_pos(delta, context):
	var target_pos = context.actor.target_pos
	var cur_pos = context.actor.get_translation()
	var dir = target_pos - cur_pos
	var len = dir.length()
	if len> 0.0 :
		var move_len = min(delta*context.motion_speed, len)
		dir = dir.normalized()
		var dest_pos = cur_pos + move_len * dir	
		if true : #terrain.is_walkable(dest_pos.x, dest_pos.z):
			context.actor.set_translation(dest_pos)
				
			# dir
			var camera = Globals.get("current_camera")
			var screen_dir = camera.unproject_position(target_pos) - camera.unproject_position(cur_pos)
			if(screen_dir.x > 0):
				context.set_anim_state(context.PS_MOVE, "walk_right", false)
			elif(screen_dir.x < 0):
				context.set_anim_state(context.PS_MOVE, "walk_left", false)
					
		else:
			set_target_pos(cur_pos)
			
		return 3	# BH_RUNNING
	else :
		return 1   	# BH_SUCCESS
		

