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
	print("why you click me")
