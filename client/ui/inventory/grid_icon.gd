extends TextureButton

func _ready():
	pass
	
func get_drag_data(pos):
	var drag_preview = preload("res://ui/inventory/drag_preview.tscn").instance()
	drag_preview.set_texture( self.get_normal_texture())
	set_drag_preview( drag_preview)
	return "haha"
	
func can_drop_data(pos, data):
	return true
	
func drop_data(pos, data):
	if data == "haha":
		var tex = preload("res://actor/flowers/flower_1.png")
		self.set_normal_texture(tex)