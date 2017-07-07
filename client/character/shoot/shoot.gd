extends KinematicBody

var advance_dir = Vector3(1.0,0.0,0.0)
var advance_speed = 50.0
var life = 3.0

func _fixed_process(delta):
	life = life - delta;
	if life < 0.0:
		queue_free()
		
	move(advance_dir*delta*advance_speed)
	
	if is_colliding():
		var collider = get_collider()
		collider.on_collision("fire")
		
		queue_free()

func _ready():
	set_fixed_process(true)
