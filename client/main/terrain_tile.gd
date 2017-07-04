extends MeshInstance

export(FixedMaterial) var material = null
export(float) var tile_size = 16
export(float) var tex_warp_size = 8

var flowers = []
var tile_items = []

func _ready():
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
	
	for i in range(tile_size * tile_size):
		tile_items.append(-1)
	
	#gen_terrain_tiles()
	gen_little_items()
	
func gen_terrain_tiles():
	var surfTool = SurfaceTool.new()
	var mesh = Mesh.new()
	surfTool.set_material(material)
	surfTool.begin(VS.PRIMITIVE_TRIANGLES)
	
	# triangle 1
	surfTool.add_uv(Vector2(0,0))
	surfTool.add_vertex(Vector3(0,0,0))
	
	surfTool.add_uv(Vector2(tex_warp_size, tex_warp_size))
	surfTool.add_vertex(Vector3(tile_size, 0, tile_size))
	
	surfTool.add_uv(Vector2(0,tex_warp_size))
	surfTool.add_vertex(Vector3(0, 0, tile_size))
	
	# triangle2
	surfTool.add_uv(Vector2(0,0))
	surfTool.add_vertex(Vector3(0,0,0))
	
	surfTool.add_uv(Vector2(tex_warp_size,  0))
	surfTool.add_vertex(Vector3(tile_size,0, 0))
	
	surfTool.add_uv(Vector2(tex_warp_size,tex_warp_size))
	surfTool.add_vertex(Vector3(tile_size, 0, tile_size))
	
	surfTool.generate_normals()
	surfTool.index()
	surfTool.commit(mesh)
	
	self.set_mesh(mesh)
	
func gen_little_items():
	var tileNum = int(tile_size * tile_size / 8)
	print(tileNum)
	for i in range(tileNum):
		var w = randi() % tile_size
		var h = randi() % tile_size
		var tileIdx = h * tile_size + w
		print(tile_items.size())
		print (tileIdx)
		if(tile_items[tileIdx]==-1):
			var flower_idx = randi() % flowers.size()
			var item = flowers[flower_idx].instance()
			item.set_translation(Vector3(w+0.5, 0, h+0.5))
			self.add_child(item)
			tile_items[tileIdx] = flower_idx
			
func get_item(x, z):
	var tileIdx = z * tile_size + x
	return tile_items[tileIdx]

