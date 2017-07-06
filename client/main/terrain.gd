extends Node

var tiles = []
var tile_view_range = int(2)
var height_color_ranges = [Vector2(-1.0, -5.3), Vector2(-4.7, -0.3), Vector2(0.3, 4.7), Vector2(5.3, 1.0)]
var height_colors = [Vector4(1.0, 0.0, 0.0, 0.0), Vector4(0.0, 1.0, 0.0, 0.0),Vector4(0.0, 0.0, 1.0, 0.0),Vector4(0.0, 0.0, 0.0, 1.0)]

export(int) var terrain_width = 8
export(int) var terrain_height = 8
export(int) var noise_seed = 666
export(int) var noise_octaves = 4
export(int) var noise_period = 64
export(int) var noise_persistance = 0.5

export(ShaderMaterial) var material = null
export(float) var tile_size = int(16)
export(float) var tex_warp_size = 4

var noise = OsnNoise.new()
var fractal_noise = OsnFractalNoise.new()

func _ready():
	set_process(true)
	
	# noise initialize
	noise.set_seed(noise_seed)
	fractal_noise.set_source_noise(noise)
	fractal_noise.set_octaves(noise_octaves)
	fractal_noise.set_period(noise_period)
	fractal_noise.set_persistance(noise_persistance)
	
func _process(delta):
	update_terrain_tile()

func get_item(x, z):
	return -1
	
func get_height( xpos, ypos):
	return fractal_noise.get_noise_2d(xpos, ypos)
	
func update_terrain_tile():
	var x_pos = int(get_main_character_pos().x / tile_size)
	var z_pos = int(get_main_character_pos().z / tile_size)
	for x in range(tile_view_range*2+1):
		for z in range(tile_view_range*2+1):
			add_terrain_tile(int(x_pos+x-2), int(z_pos+z-2))
			
	# clean
	var i = 0
	while i < tiles.size():
		var tile = tiles[i]
		var g_pos = tile.get_global_transform().origin / tile_size
		if not( abs(g_pos.x-x_pos)<=tile_view_range and abs(g_pos.z-z_pos)<=tile_view_range):
			tiles.remove(i)
			self.remove_child(tile)
			tile.queue_free()
		else:
			i+=1

func add_terrain_tile(x_coord, z_coord):
	var pos = Vector3(x_coord*tile_size,0,z_coord*tile_size)
	if not is_tile_exist(x_coord, z_coord):
		var tile_res = preload("res://main/terrain_tile.tscn")
		var tile = tile_res.instance()
		gen_tile_mesh(tile, pos)
		tile.set_translation(pos)
		self.add_child(tile)
		tiles.append(tile)
		
		print("append tile:", pos)
	
func is_tile_exist(x_coord, z_coord):
	for tile in tiles:
		var g_pos = tile.get_global_transform().origin / tile_size
		if abs(g_pos.x-x_coord)<1 and abs(g_pos.z-z_coord)<1:
			return true
			
	return false
	
func gen_tile_mesh(tile, pos):
	var surfTool = SurfaceTool.new()
	var mesh = Mesh.new()
	surfTool.set_material(material)
	surfTool.begin(VS.PRIMITIVE_TRIANGLES)
	
	for h in range(tile_size):
		for w in range(tile_size):
			var ww = pos.x + w
			var hw = pos.z + h
			var h0 = get_height(ww,hw)
			var h1 = get_height(ww+1, hw)
			var h2 = get_height(ww, hw+1)
			var h3 = get_height(ww+1, hw+1)
			
			# triangle 1
			surfTool.add_color(get_color_by_height(h0))
			surfTool.add_uv(Vector2(w,h))
			surfTool.add_vertex(Vector3(w,0,h))

			surfTool.add_color(get_color_by_height(h3))	
			surfTool.add_uv(Vector2(w+1, h+1))
			surfTool.add_vertex(Vector3(w+1, 0, h+1))

			surfTool.add_color(get_color_by_height(h2))
			surfTool.add_uv(Vector2(w,h+1))
			surfTool.add_vertex(Vector3(w, 0, h+1))

			# triangle2
			surfTool.add_color(get_color_by_height(h0))			
			surfTool.add_uv(Vector2(w,h))
			surfTool.add_vertex(Vector3(w,0,h))

			surfTool.add_color(get_color_by_height(h1))
			surfTool.add_uv(Vector2(w+1,  h))
			surfTool.add_vertex(Vector3(w+1,0, h))

			surfTool.add_color(get_color_by_height(h3))
			surfTool.add_uv(Vector2(w+1,h+1))
			surfTool.add_vertex(Vector3(w+1, 0, h+1))

	surfTool.generate_normals()
	surfTool.index()
	surfTool.commit(mesh)
	
	tile.set_mesh(mesh)
	
func get_color_by_height(height):
	var idx = int(0)
	while idx < height_color_ranges.size():
		if(height>height_color_ranges[idx].y):
			idx+=1
	
	if height>-1 and height<=-0.5:
		return Color(1.0, 0.0, 0.0, 0.0)
	elif height>-0.5 and height<=0:
		return Color(0.0, 1.0, 0.0, 0.0)
	elif height>0.0 and height<=0.5:
		return Color(0.0, 0.0, 1.0, 0.0)
	elif height>0.5 and height<=1.0:
		return Color(0.0, 0.0, 0.0, 1.0)
	
func get_main_character_pos():
	var main_character = get_tree().get_root().get_node("root/characters/actor0")
	if main_character:
		return main_character.get_translation()
	else:
		return Vector3(0,0,0)

# perlin noise	
func generate_noise_map( width, height, scale):
	var noise_map = []
	for y in range(height):
		for x in range(width):
			var sample_x = x / scale
			var sample_y = y / scale
			var perlin_value = fractal_noise.get_noise_2d( sample_x, sample_y)
			noise_map.append(perlin_value)	
	
	return noise_map
	
	