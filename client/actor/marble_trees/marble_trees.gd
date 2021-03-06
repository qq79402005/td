extends StaticBody

var item = null
var is_on_fire = false
var fire_time = 0.0

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if is_on_fire:
		fire_time += delta;
		if fire_time > 3.0:
			get_parent().queue_free()

func on_collision(info):
	if info=="fire":
		is_on_fire = true
		
		var fire = preload("res://effect/fire/fire.tscn").instance()
		get_parent().add_child(fire)
	
func set_item(_item):
	item = _item
	
func get_type():
	return "item"
	
func get_id():
	return item.id
	
func on_clicked():
	print("why you click me")