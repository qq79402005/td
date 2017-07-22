extends Camera

var ray_length = 1000
var ray_from = Vector3()
var ray_to = Vector3()
var is_touch = false
var scene_rotate_y = 0

func _ready():
	Globals.set("current_camera", self)
	scene_rotate_y = get_parent().get_rotation_deg().y
	set_process_input(true)
	set_fixed_process(true)

func _input(event):
#func _unhandled_input(event):
	if(event.type==InputEvent.MOUSE_BUTTON and event.pressed and event.button_index==1):
		ray_from = self.project_ray_origin(event.pos)
		ray_to = ray_from + self.project_ray_normal(event.pos) * ray_length
		is_touch = true
		
	# rotate camera
	if(event.is_action_pressed("scene_rotate")):
		scene_rotate_y += 45
		
func _fixed_process(delta):
	if is_touch:
		###
		
		###
		var space_state = get_world().get_direct_space_state()
		var result = space_state.intersect_ray(ray_from, ray_to)
		if not result.empty():
			var collider = result["collider"]
			if collider.get_type() == "item":
				collider.on_clicked()
			else:		
				get_parent().set_target_pos(result.position)
				#get_tree().get_root().get_node("level/ui/item_operate").set_hidden(true)
			
		is_touch = false
	
	# rotate scene
	rotate_scene()
		
func rotate_scene():
	var cur_rotate = get_parent().get_rotation_deg()
	if(cur_rotate.y != scene_rotate_y):
		cur_rotate.y += min( 4, scene_rotate_y-cur_rotate.y)
		get_parent().set_rotation_deg(cur_rotate)
			