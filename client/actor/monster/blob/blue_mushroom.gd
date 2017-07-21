extends Spatial

export(float) var attack_range = 1.2
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
			
func on_attack_end():
	var main_character = Globals.get("main_character")
	var main_character_pos = main_character.get_translation()
	var cur_pos = get_translation()
	var dir = main_character_pos - cur_pos
	var len = dir.length()
	print("len:", len, "range:", attack_range)
	
	if len < attack_range:
		main_character.on_attack(15)