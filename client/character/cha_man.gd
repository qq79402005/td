extends Node

func _ready():
	self.get_node("AnimationPlayer").play("idle")
	
func mirror(value):
	get_node("AnimatedSprite3D").set_flip_h(value)

func fire_ball():
	var bullet = preload("res://character/shoot/shoot.tscn").instance()
	bullet.advance_speed = 10
	
	if(get_node("AnimatedSprite3D").is_flipped_h()):
		bullet.set_translation(Vector3(-0.5,0.5,0))
	else:
		bullet.set_translation(Vector3(1.5,0.5,0))
	get_parent().add_child(bullet)
