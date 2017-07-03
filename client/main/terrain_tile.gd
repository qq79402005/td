extends MeshInstance

export(FixedMaterial) var material = null
export(float) var tile_size = 16

func _ready():
	var surfTool = SurfaceTool.new()
	var mesh = Mesh.new()
	surfTool.set_material(material)
	surfTool.begin(VS.PRIMITIVE_TRIANGLES)
	
	# triangle 1
	surfTool.add_uv(Vector2(0,0))
	surfTool.add_vertex(Vector3(0,0,0))
	
	surfTool.add_uv(Vector2(0,1))
	surfTool.add_vertex(Vector3(0, 0, tile_size))
	
	surfTool.add_uv(Vector2(1,  1))
	surfTool.add_vertex(Vector3(tile_size, 0, tile_size))
	
	# triangle2
	surfTool.add_uv(Vector2(0,0))
	surfTool.add_vertex(Vector3(0,0,0))
	
	surfTool.add_uv(Vector2(1,1))
	surfTool.add_vertex(Vector3(tile_size, 0, tile_size))
	
	surfTool.add_uv(Vector2(1,  0))
	surfTool.add_vertex(Vector3(tile_size,0, 0))
	
	surfTool.generate_normals()
	surfTool.index()
	surfTool.commit(mesh)
	
	self.set_mesh(mesh)
