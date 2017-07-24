extends Control

func _ready():
	# login
	get_node("/root/network").login()
	pass
	
func set_slot_size( size):
	clear()
	var slotRs = preload("res://ui/inventory/grid.tscn")
	var container = get_node("bg/GridContainer")
	for i in range(5):
		var slot = slotRs.instance()
		container.add_child(slot)
		
func set_slot_info(cell_idx, item_id, item_num):
	var container = get_node("bg/GridContainer")
	print("+++++++++++++++++++++++++++++++++++++")
	if cell_idx < container.get_child_count():
		var tex = get_node("/root/items").get_item_icon(item_id)
		var slot = container.get_child(cell_idx)
		slot.get_node("icon").set_normal_texture(tex)
		print(item_num)
		slot.get_node("icon/label").set_text(String(item_num))
		print("*******************************************")
	
	
func clear():	
	for child in get_node("bg/GridContainer").get_children():
		child.queue_free()

func _on_close_pressed():
	set_hidden(true)
