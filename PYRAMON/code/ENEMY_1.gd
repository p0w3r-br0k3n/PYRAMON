extends KinematicBody
var space_state
var target
var speed = 100
func _ready():
	space_state = get_world().direct_space_state

func _process(delta):
	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		if result.collider.is_in_group("Player"):
			
			look_at(target.global_trasform.origin, Vector3.UP)
			move_to_target(delta)
			print("fire")
		else:
			print("hi")
func move_to_target(delta):
	var direction = (target.transform.origin - transform.origin).normalised()
	move_and_slide(direction*speed*delta,Vector3.UP)
func _on_Area_body_entered(body):
	if body.is_in_group("prot"):
		target= body
		print(1)


func _on_Area_body_exited(body):
	if body.is_in_group("prot"):
		target= null
		print(2)
