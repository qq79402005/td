extends StaticBody

var item = null

func _ready():
	pass
	
func set_item(_item):
	item = _item
		
func get_type():
	return "item"
	
func get_id():
	return item.id
	
func on_clicked():
	var item_id = get_id()
	if(item_id!=-1):
		var main_cha = Globals.get("main_character")
		main_cha.set_target_pos( get_global_transform().origin)
		
		get_node("/root/network").collect_item(item_id)
		get_parent().get_parent().remove_child(get_parent())
		
		
	
