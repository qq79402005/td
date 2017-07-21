extends BTActionNode

export(int, "BH_ERROR", "BH_SUCCESS", "BH_FAILURE", "BH_RUNNING") var update_result = 0

func _bt_update(index, context):
	var main_character = Globals.get("main_character")
	var main_character_pos = main_character.get_translation()
	var cur_pos = context.actor.get_translation()
	if( main_character_pos-cur_pos).length_squared() < 25.0:
		return 1
		
	return 2
	
