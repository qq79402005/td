extends BTActionNode

export(bool) var pursuit_player = false
export(float)var pursuit_check_time = 2.0
var target_pos
export(int, "BH_ERROR", "BH_SUCCESS", "BH_FAILURE", "BH_RUNNING") var update_result = 0

func _bt_continue(index, context):
	pursuit_check_time -= context.tick_time
	if pursuit_player and pursuit_check_time<0:
		var main_character = Globals.get("main_character")
		target_pos = main_character.get_translation()
		pursuit_check_time = 2.0

func _bt_prepare(index, context):
	if pursuit_player:
		var main_character = Globals.get("main_character")
		target_pos = main_character.get_translation()
	else:
		target_pos = context.get_next_random_patrol_pos()

func _bt_update(index, context):
	update_result = move_to_target_pos( context.tick_time, context)
	return update_result

func _bt_abort(index, context):
	pass
	
func move_to_target_pos(delta, context):
	var cur_pos = context.actor.get_translation()
	var dir = target_pos - cur_pos
	var len = dir.length()
	if len>0 :
		var move_len = min(delta*context.motion_speed, len)
		dir = dir.normalized()
		var dest_pos = cur_pos + move_len * dir	
		if true : #terrain.is_walkable(dest_pos.x, dest_pos.z):
			context.actor.set_translation(dest_pos)
				
			# dir
			var camera = Globals.get("current_camera")
			var screen_dir = camera.unproject_position(target_pos) - camera.unproject_position(cur_pos)
			if(screen_dir.x > 0):
				context.set_anim_state(context.PS_MOVE, "walk_left", false)
			elif(screen_dir.x < 0):
				context.set_anim_state(context.PS_MOVE, "walk_right", false)
					
		else:
			set_target_pos(cur_pos)
			
		return 3	# BH_RUNNING
	else :
		return 1   	# BH_SUCCESS
		

