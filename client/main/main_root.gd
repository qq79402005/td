# main scene root node
extends Node

func _ready():
	pass

# return to up scene
func _on_back_pressed():
	get_node("/root/global").setScene("res://launch/launch.tscn")
