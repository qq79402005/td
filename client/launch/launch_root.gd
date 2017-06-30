# launch root node
extends Node

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

# start game
func _on_start_pressed():
	get_node("/root/global").setScene("res://select/select.tscn")

# quit game
func _on_quite_pressed():
	get_tree().quit()
