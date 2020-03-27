extends KinematicBody


var vel = Vector3(0,0,0)
const sp=3
const leg_force= 50
const forward_jump = 30

const gravity = -3





func _ready():
	pass
func _physics_process(delta):
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		vel.x=0
	elif Input.is_action_pressed("ui_right"):
		vel.x = sp
		$walking.play("walking")
		
		
	elif Input.is_action_pressed("ui_left"):
		vel.x=-sp
		
		
	else:
		vel.x=lerp(vel.x,0,0.1)
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		vel.y=0
		
	elif Input.is_action_just_pressed("ui_up") and Input.is_action_pressed("ui_right"):
		vel.y=leg_force
		vel.x=forward_jump
	elif Input.is_action_just_pressed("ui_up"):
		vel.y=leg_force
		
	else:
		vel.y=lerp(vel.z,0,0.1)
	vel.y += gravity
	move_and_slide(vel)
	
	
	

	

