extends KinematicBody
onready var Player = get_parent().get_node("Player")
var space_state
var target
const speed = 300
var dir = 0
var pos = Vector3(0, 0, 0)
const gravity = 600
var last_trans = translation
var accel = 0
var new_pos= Vector3(0,0,0)
var health=10
onready var sho = get_tree().get_root().get_node("/root/level/enem/hand_swervel/hand_right/scene_root")
const leg_force= 600
const forward_jump = 300
var physics_delta = 0;
var vel= Vector3(0,0,0)
func _ready():
	space_state = get_world().direct_space_state
	pos = global_transform.origin
	$AnimationPlayer.play("holster")
func get_translation_delta():
	var delta = last_trans - translation
	last_trans = translation
	return delta
# warning-ignore:unused_argument
func _physics_process(delta):
	if health <=0:
		hide()
		$respawn.start()

func _process(delta):
	if pos != new_pos:
		pos = new_pos 
		
	if sho.reload == 0:
		$AnimationPlayer.play("relaoad_pistol_hands")
		


	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		if result.collider:
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
	vel.y += -gravity * delta;
	vel.x = dir * speed

	vel = move_and_slide(vel, Vector3(0, -1,0))
	
func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		target= body
		print(1)


func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		target= null
		print(2)

func hurt():
	health=health-10

func _on_respawn_timeout():
	print("tome")
	$respawn.stop()
