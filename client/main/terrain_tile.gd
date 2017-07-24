extends MeshInstance

export(float) var tile_size = int(16)

var terrain = null
var tile_items = []
var tile_item_nodes = []

func _ready():
	terrain = get_parent()
	
	for i in range(tile_size * tile_size):
		tile_items.append(-1)
	
	#gen_little_items()
	
func _exit_tree():
	var root_actor_node = get_node("/root/level/actor")
	for i in range(tile_item_nodes.size()):
		if tile_item_nodes[i]!=null:
			root_actor_node.remove_child(tile_item_nodes[i])
			
	tile_item_nodes.clear()
	
func gen_little_items():
	var items = get_node("/root/items")
	#for i in range(items.get_item_count()):
	#	var item = items.get_item_by_index(i)
	
	var root_actor_node = get_node("/root/level/actor")
	var itemNum = int(tile_size * tile_size / 12)
	for i in range(itemNum):
		var w = randi() % tile_size
		var h = randi() % tile_size
		var tileIdx = h * tile_size + w
		if(tile_items[tileIdx]==-1):
			var flower_idx = randi() % items.get_item_count()
			
			var tile_pos = self.get_translation()
			if terrain.is_plantable(flower_idx, w+tile_pos.x, h+tile_pos.z):
				var item = items.get_item_by_index(flower_idx).res_load.instance()
				var item_half_height = 0#item.get_region_rect().size.y / 2
				item.set_translation(Vector3(tile_pos.x + w+0.5, item_half_height, tile_pos.z + h+0.5))
				root_actor_node.add_child(item)
				tile_item_nodes.append(item)
				tile_items[tileIdx] = flower_idx
							
				if item.has_node("collider"):
					var collider = item.get_node("collider")
					collider.set_item(items.get_item_by_index(flower_idx))
				
			
func get_item(x, z):
	var tileIdx = z * tile_size + x
	if(tileIdx < tile_items.size() and tileIdx >= 0):
		return tile_items[tileIdx]
	else :
		return -1
