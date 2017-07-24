# launch root node
extends CanvasLayer

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

# start game
func _on_start_pressed():	
		# change scene
	get_node("/root/global").setScene("res://main/main.tscn")
	
	# login
	get_node("/root/network").login()

# quit game
func _on_quite_pressed():
	get_tree().quit()
