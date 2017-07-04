extends Control

func _ready():
	pass
	
# show use able skill
func show(pos):
	self.set_hidden(false)
	
	var ui_half_size = self.get_rect().size / 2 
	var ui_pos  = Vector2(pos.x - ui_half_size.x, pos.y - ui_half_size.y)
	
	self.set_pos(ui_pos)
