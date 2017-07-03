extends Spatial

var speed = 3

func _ready():
	set_process(true)
	
func _process(delta):
	var dir = Vector3(0,0,0)

	if(Input.is_key_pressed(KEY_LEFT)):	
		dir.x -= 1
	if(Input.is_key_pressed(KEY_RIGHT)):	
		dir.x += 1
	if(Input.is_key_pressed(KEY_UP)):	
		dir.z -= 1
	if(Input.is_key_pressed(KEY_DOWN)):	
		dir.z += 1
	
	if(dir.length_squared()>0):
		dir = dir.normalized()
		var curPos = self.get_translation() + dir * speed * delta;
		self.set_translation(curPos)
		
