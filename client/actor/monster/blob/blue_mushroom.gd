extends Spatial

var attack_range_effect = null;

func _ready():
	
	pass

func show_acctack_target(target, show):
	if show:
		if attack_range_effect == null:
			attack_range_effect = load("res://actor/monster/blob/attack_range_circle.tscn").instance()
			get_node("/root/level/actor").add_child(attack_range_effect)
			attack_range_effect.get_node("AnimationPlayer").play("show")
			attack_range_effect.set_translation(target)
	else:
		if attack_range_effect!=null:
			get_node("/root/level/actor").remove_child(attack_range_effect)
			attack_range_effect = null