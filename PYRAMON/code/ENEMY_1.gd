extends KinematicBody
var space_state
var target
const speed = 300
const gravity = 981
var last_trans = translation
var accel = 0
const leg_force= 500
const forward_jump = 300
var physics_delta = 0;
var vel= Vector3(0,0,0)
func _ready():
	space_state = get_world().direct_space_state
	
func _physics_process(delta):
	pass
func _process(delta):
	
	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		if result.collider.is_in_group("Player"):
			
			move_to_target(delta)
			print("fire")
			print("vel",vel,"sp",speed)
		else:
			pass
func move_to_target(delta):
	var direction = (target.transform.origin - transform.origin)
	if speed>0:
		$AnimationPlayer.play("walking")
	elif speed<0:
		$AnimationPlayer.play("walking_left")
	vel.y=gravity
	vel.x= speed
	move_and_slide(direction*vel*delta,Vector3.UP)
func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		target= body
		print(1)


func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		target= null
		print(2)
