extends KinematicBody
var damage=10
var speed = 8
var velocity = Vector3()

func _ready():
	velocity = Vector3(speed, 0, 0)

func set_speed(blyat):
	velocity = blyat.normalized()*speed

func _physics_process(delta):
	move_and_slide(velocity, Vector3(0, 0, 0), false, 3, 0.785398, false)
	for i in get_slide_count():
		var col = get_slide_collision(i)
		var queue_free = true
		if(col):
			print(col.collider.name)
			var groups = col.collider.get_groups()
			for g in groups:
				if(g == "enemy"):
					# col.collider.apply_central_impulse(-col.normal*3)
					print("Tried to hurt someone")
					col.collider.hurt()
					
				elif (g == "Player"):
					print("Player was hurt!")
					col.collider.hurt()
				if(g == "case"):
					queue_free = false
		
		if(queue_free):
			queue_free()


func _on_Area_body_entered(body):
	print(1)
