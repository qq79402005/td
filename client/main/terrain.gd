extends Node

func _ready():
	set_process(true)
	
	var x_pos = int(get_main_character_pos().x / 16)
	var z_pos = int(get_main_character_pos().z / 16)
	for x in range(5):
		for z in range(5):
			add_terrain_tile(Vector3(x_pos + (x-2)*16,0,z_pos+(z-2)*16))
	
func _process(delta):
	pass

func get_item(x, z):
	return -1
	
func add_terrain_tile(pos):
	var tile_res = preload("res://main/terrain_tile.tscn")
	var tile = tile_res.instance()
	tile.set_translation(pos)
	self.add_child(tile)
	
func get_main_character_pos():
	return get_tree().get_root().get_node("root/characters/actor0").get_translation()