extends MeshInstance

export(float) var tile_size = int(16)

var terrain = null
var flowers = []
var tile_items = []

func _ready():
	terrain = get_parent()
	
	init_flower_list()
	
	for i in range(tile_size * tile_size):
		tile_items.append(-1)
	
	gen_little_items()
	
func gen_little_items():
	var itemNum = int(tile_size * tile_size / 12)
	for i in range(itemNum):
		var w = randi() % tile_size
		var h = randi() % tile_size
		var tileIdx = h * tile_size + w
		if(tile_items[tileIdx]==-1):
			var flower_idx = randi() % flowers.size()
			
			var tile_pos = self.get_translation()
			if terrain.is_plantable(flower_idx, w+tile_pos.x, h+tile_pos.z):
				var item = flowers[flower_idx].instance()
				var item_half_height = 0#item.get_region_rect().size.y / 2
				item.set_translation(Vector3(w+0.5, item_half_height, h+0.5))
				self.add_child(item)
				tile_items[tileIdx] = flower_idx
			
func get_item(x, z):
	var tileIdx = z * tile_size + x
	if(tileIdx < tile_items.size() and tileIdx >= 0):
		return tile_items[tileIdx]
	else :
		return -1
		
func init_flower_list():
	flowers.append(preload("res://actor/tools/axe.tscn"))
	flowers.append(preload("res://actor/flowers/flower_1.tscn"))
	flowers.append(preload("res://actor/flowers/flower_2.tscn"))
	flowers.append(preload("res://actor/flowers/flower_3.tscn"))
	flowers.append(preload("res://actor/flowers/flower_4.tscn"))
	flowers.append(preload("res://actor/flowers/flower_5.tscn"))
	flowers.append(preload("res://actor/flowers/flower_6.tscn"))
	flowers.append(preload("res://actor/flowers/flower_7.tscn"))
	flowers.append(preload("res://actor/flowers/flower_8.tscn"))
	flowers.append(preload("res://actor/flowers/flower_9.tscn"))
	flowers.append(preload("res://actor/flowers/flower_10.tscn"))
	flowers.append(preload("res://actor/marble_trees/marble_tree.tscn"))

