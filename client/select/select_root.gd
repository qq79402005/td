extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_back_pressed():
	get_node("/root/global").setScene("res://launch/launch.tscn")
	


func _on_enter_pressed():
	get_node("/root/global").setScene("res://main/main.tscn")
