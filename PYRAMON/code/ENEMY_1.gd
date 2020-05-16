extends KinematicBody
var space_state
var target
const speed = 300
const gravity = 981
var last_trans = translation
var accel = 0
onready var sho = get_tree().get_root().get_node("/root/level/enem/hand_swervel/hand_right/scene_root")
const leg_force= 500
const forward_jump = 300
var physics_delta = 0;
var vel= Vector3(0,0,0)
func _ready():
	space_state = get_world().direct_space_state
func get_translation_delta():
	var delta = last_trans - translation
	last_trans = translation
	return delta
func _physics_process(delta):
	vel.x=speed
func _process(delta):
	move_and_slide(vel*physics_delta, Vector3(0, 1, 0), false, 4, 0.785398, true)
	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		if result.collider.is_in_group("Player"):
			sho.shoot()
		
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
