extends Camera

var ray_length = 1000

func _ready():
	set_process_input(true)
	
func _input(event):
	if(event.type==InputEvent.MOUSE_BUTTON and event.pressed and event.button_index==1):
		var from = self.project_ray_origin(event.pos)
		var to = from + self.camera.project_ray_normal(event.pos) * ray_length

		var space_state = get_world().get_direct_space_state()
		var result = space_state.intersect_ray(from, to)
		if not result.empty():
			print("hit a point", result.position)