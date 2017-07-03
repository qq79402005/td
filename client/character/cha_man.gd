extends Node

func _ready():
	self.get_node("AnimationPlayer").play("idle")
	
func mirror(value):
	get_node("AnimatedSprite3D").set_flip_h(value)
