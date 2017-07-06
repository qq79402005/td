extends Node

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
	
	var x_pos = int(get_main_character_pos().x / 16)
	var z_pos = int(get_main_character_pos().z / 16)
	for x in range(5):
		for z in range(5):
			add_terrain_tile(Vector3(x_pos + (x-2)*16,0,z_pos+(z-2)*16))
	
func _process(delta):
	pass

func get_item(x, z):
	return -1
	
func get_height( xpos, ypos):
	return fractal_noise.get_noise_2d(xpos, ypos)
	
func add_terrain_tile(pos):
	var tile_res = preload("res://main/terrain_tile.tscn")
	var tile = tile_res.instance()
	gen_tile_mesh(tile, pos)
	tile.set_translation(pos)
	self.add_child(tile)
	
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
	
	