extends KinematicBody

var at = Vector3(4,35,-80)
var to = Vector3(-4,-25,80)
var vel = Vector3(0,0,0)
var accel = 0
var last_trans = translation
const sp = 300
const leg_force= 500
const forward_jump = 300
var physics_delta = 0;
var holster_pistol= 0
var hol_time_pist=0
const gravity = -981
var holster_not_fire = 0
var reload_hands=0
#the var holster_not_fire should be called from the pistol_root script so as not to fire when you holster/unholster

func get_translation_delta():
	var delta = last_trans - translation
	last_trans = translation
	return delta

func _ready():
	pass

func _process(_delta):
	move_and_slide(vel*physics_delta, Vector3(0, 1, 0), false, 4, 0.785398, true)
	if Input.is_action_just_pressed("run") and Input.is_action_pressed("ui_left"):
		pass
		
	elif Input.is_action_just_pressed("run") and Input.is_action_just_pressed("ui_right"):
		pass
	elif Input.is_action_just_released("run"): 
		pass
	if Input.is_action_just_pressed("1"):
		holster_not_fire=1
		if holster_pistol == 0 and hol_time_pist==0:
			
			holster_pistol=1
			$walking.play("holster")
			$holster_time.start()
			$show_pistol.start()
			
		elif holster_pistol == 1 and hol_time_pist==1:
			
			holster_pistol=0
			$walking.play("unhol_pistol")
			$unholster_time.start()
			$hide_pistol.start()
			
func _physics_process(delta):
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		vel.x = 0
		
	elif Input.is_action_pressed("ui_right"):
		vel.x = sp
		$walking.play("walking")
	elif Input.is_action_pressed("ui_left"):
		$walking.play("walking")
		vel.x = -sp
	elif Input.is_action_just_pressed("ctrl"):
		$walking.play("crouching")
	elif Input.is_action_just_released("ctrl"):
		$walking.play("up")
	else:
		vel.x = lerp(vel.x,0,0.1)
	
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down") and is_on_floor():
		vel.y=0
	elif Input.is_action_pressed("ui_up") and is_on_floor():
		accel = leg_force
	else:
		vel.y = lerp(vel.z,0,0.1)
	
	if get_translation_delta().y == 0:
		accel = 0
	if Input.is_action_just_pressed("ui_rel") and reload_hands==0:
		$walking.play("reload_pistol_hands") 
	accel += gravity*delta
	vel.y += accel
	physics_delta = delta
	
	
func _on_Area_body_entered(body):
	if(body.name == "prot") and is_on_floor():
		translate(at)
		print ("yeet1")


func _on_Area2_body_entered(body):	
	if(body.name == "prot") and is_on_floor():
		translate(to)
		print("yeet2")





func _on_holster_time_timeout():
	hol_time_pist=1
	holster_not_fire=0
	$holster_time.stop()
	
	
func _on_unholster_time_timeout():
	hol_time_pist=0

	holster_not_fire=0
	$unholster_time.stop()
	


func _on_hide_pistol_timeout():
	$hand_swervel/hand_right/scene_root.hide()
	$hide_pistol.stop()


func _on_show_pistol_timeout():
	$hand_swervel/hand_right/scene_root.show()
	$show_pistol.stop()


func _on_empty_mag_timeout():
	reload_hands=1
