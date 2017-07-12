extends CanvasLayer

func _ready():
	pass

func _on_back_pressed():
	get_node("/root/global").setScene("res://launch/launch.tscn")

func _on_enter_pressed():
	# login
	get_node("/root/network").login()
	
	# change scene
	get_node("/root/global").setScene("res://main/main.tscn")
