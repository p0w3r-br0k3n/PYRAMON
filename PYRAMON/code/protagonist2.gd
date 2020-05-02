extends KinematicBody
onready var pistol = get_tree().get_root().get_node("/root/level/prot/hand_swervel/hand_right/scene_root")
var at = Vector3(4,35,-80)
var to = Vector3(-4,-25,80)
var vel = Vector3(0,0,0)
var accel = 0
var health = 0

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
var left_right=0
var ok_die=0
func get_translation_delta():
	var delta = last_trans - translation
	last_trans = translation
	return delta

	

func _ready():

	add_to_group("enemy")
	add_to_group("Player")
	$walking.play("holster")
	$holster_time.start()
func _process(_delta):
	
	if health ==0:
		$hide.start()
	if Input.is_action_just_pressed("ui_left"):
		left_right=1
	if Input.is_action_just_pressed("ui_right"):
		left_right = 0
	move_and_slide(vel*physics_delta, Vector3(0, 1, 0), false, 4, 0.785398, true)
	if Input.is_action_just_pressed("run") and Input.is_action_pressed("ui_left"):
		pass
		
	elif Input.is_action_just_pressed("run") and Input.is_action_just_pressed("ui_right"):
		pass
	elif Input.is_action_just_released("run"): 
		pass
	

func _physics_process(delta):
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		vel.x = 0
		
	elif Input.is_action_pressed("ui_right"):
		vel.x = sp
	
		$walking.play("walking")
		
	elif Input.is_action_pressed("ui_left"): 
		
		
		$walking.play("walking_left")
		
		vel.x = -sp
	
	elif Input.is_action_just_pressed("ctrl"):
		if left_right==0:
			$walking.play("crouching")
		elif left_right==1:
			pass
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
	if Input.is_action_just_pressed("ui_rel") and pistol.stop==0 and pistol.cant_shoot==0 and pistol.no_ammo == 0:
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
	pistol.start=1
	$holster_time.stop()
	




func _on_empty_mag_timeout():
	reload_hands=1


func _on_hide_timeout():
	$head.hide()
	$foot_left.hide()
	$foot_right.hide()
	$body_middle.hide()
	$body_up.hide()
	$body_down.hide()
	$hand_swervel.hide()
	$hide.stop()
	$hide2.start()


func _on_hide2_timeout():
	$head.show()
	$foot_left.show()
	$foot_right.show()
	$body_middle.show()
	$body_up.show()
	$body_down.show()
	$hand_swervel.show()
	$hide2.stop()
	$hide3.start()

func _on_hide3_timeout():
	$head.hide()
	$foot_left.hide()
	$foot_right.hide()
	$body_middle.hide()
	$body_up.hide()
	$body_down.hide()
	$hand_swervel.hide()
	$hide3.stop()
	$hide4.start()



func _on_hide4_timeout():
	$head.show()
	$foot_left.show()
	$foot_right.show()
	$body_middle.show()
	$body_up.show()
	$body_down.show()
	$hand_swervel.show()
	
	$hide.stop()
	$die.start()
	
	


func _on_die_timeout():
	ok_die=1
	queue_free()


