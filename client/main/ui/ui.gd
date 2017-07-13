extends CanvasLayer

func _ready():
	pass

func _on_backpack_button_pressed():
	get_node("big bag").popup()
