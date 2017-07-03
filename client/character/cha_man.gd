extends Node

func _ready():
	self.get_node("AnimationPlayer").play("idle")
