extends TextureButton

var idx = -1
var item_id  = -1
var item_num = 0

class DragData:
	var type
	var slot
	
	func _init( slot):
		self.type = "item"
		self.slot = slot

func _ready():
	pass
	
func set_cell_idx(idx):
	self.idx = idx
	
func set_slot_info(id, num):
	item_id = id
	item_num = num
	
func get_drag_data(pos):
	var drag_preview = preload("res://ui/inventory/drag_preview.tscn").instance()
	drag_preview.set_texture( self.get_normal_texture())
	set_drag_preview( drag_preview)
	return DragData.new(self)
	
func can_drop_data(pos, data):
	return true
	
func drop_data(pos, data):
	if data.type == "item":
		var tex = preload("res://actor/flowers/flower_1.png")
		self.set_normal_texture(tex)

func _on_icon_pressed():
	if item_num > 0 :
		var item = get_node("/root/items").get_item_by_id(item_id)
		if item!=null and item.is_can_eat == true:
			if Globals.get("main_character").max_blood > Globals.get("main_character").cur_blood:	
				get_node("/root/network").eat_item(idx)
			else:
				print("blood is full, please don't eat anymore")
