extends Control

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func clear():	
	for child in get_node("bg/GridContainer").get_children():
		child.queue_free()
