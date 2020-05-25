extends KinematicBody
var damage=10
var speed = 8
var velocity = Vector3()
onready var healt=  get_node("/root/level/prot")
onready var enhealt=  get_node("/root/level/enem")

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
					col.collider.apply_central_impulse(-col.normal*3)
					col.collider.hurt()
					
					enhealt.health=enhealt.health-damage
				elif (g == "Player"):
				
					healt.health=healt.health-damage


				if(g == "case"):
					queue_free = false
		
		if(queue_free):
			queue_free()
