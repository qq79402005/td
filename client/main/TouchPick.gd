extends Camera

var ray_length = 1000
var ray_from = Vector3()
var ray_to = Vector3()
var is_touch = false

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	
func _input(event):
	if(event.type==InputEvent.MOUSE_BUTTON and event.pressed and event.button_index==1):
		ray_from = self.project_ray_origin(event.pos)
		ray_to = ray_from + self.project_ray_normal(event.pos) * ray_length
		is_touch = true
		
func _fixed_process(delta):
	if is_touch:
		var space_state = get_world().get_direct_space_state()
		var result = space_state.intersect_ray(ray_from, ray_to)
		if not result.empty():
			print("hit a point", result.position)
			
			var item = get_tree().get_root().get_node("root/terrain/terrain_tile").get_item(int(result.position.x), int(result.position.z))
			print(item)
			
			#show ui
			if(item!=-1):
				var screen_point = self.unproject_position(result.position)
				get_tree().get_root().get_node("root/ui/item_operate").show(screen_point)
			else:
				get_parent().set_target_pos(result.position)
				get_tree().get_root().get_node("root/ui/item_operate").set_hidden(true)
			
		is_touch = false