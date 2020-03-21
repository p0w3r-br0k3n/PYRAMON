extends KinematicBody

var speed = 1
var velocity = Vector3()


func _ready():
	velocity = Vector3(speed, 0, 0)


func set_speed(blyat):
	velocity = blyat.normalized()*speed

func _physics_process(delta):
	
	move_and_slide(velocity, Vector3(0, 0, 0), false, 3, 0.785398, false)
	for i in get_slide_count():
		var col = get_slide_collision(i)
		if(col):
			if(col.collider is RigidBody):
				col.collider.apply_central_impulse(-col.normal*3)
				# col.collider.hurt()
			# queue_free()
