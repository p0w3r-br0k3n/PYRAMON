extends KinematicBody

var vel = Vector3(0,0,0)
const sp=5
const rot= (deg2rad(7))
func _ready():
	pass
func _physics_process(delta):
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		vel.x=0
	elif Input.is_action_pressed("ui_right"):
		vel.x = sp
		
		$CollisionShape/MeshInstance.rotate_z(-rot)
	elif Input.is_action_pressed("ui_left"):
		vel.x=-sp
		
		$CollisionShape/MeshInstance.rotate_z(rot)
	else:
		vel.x=lerp(vel.x,0,0.1)
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		vel.z=0
		
	elif Input.is_action_pressed("ui_up"):
		vel.z=-sp
		$CollisionShape/MeshInstance.rotate_x(-rot)
	elif Input.is_action_pressed("ui_down"):
		vel.z=sp
		
		$CollisionShape/MeshInstance.rotate_x(rot)
	else:
		vel.z=lerp(vel.z,0,0.1)
	move_and_slide(vel)