extends KinematicBody
onready var pistol = get_tree().get_root().get_node("/root/level/prot/hand_swervel/hand_right/scene_root")
var at = Vector3(4,35,-80)
var to = Vector3(-4,-35,80)
var vel = Vector3(0,0,0)
var accel = 0
var health = 100
onready var part = get_tree().get_root().get_node("/root/level/Area/Particles")
onready var part2 = get_tree().get_root().get_node("/root/level/Area2/Particles2")
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
	health=health-1
	
	if health<=100 and health>=81:
		$health/Label.show()
		
	elif health<=80 and health>=61:
		$health/Label.hide()
		$health/Label2.show()
	
	elif health<=60 and health>=41:
		$health/Label.hide()
		$health/Label2.hide()
		$health/Label3.show()
	elif health<=40 and health>=21:
		$health/Label.hide()
		$health/Label2.hide()
		$health/Label3.hide()
		$health/Label4.show()
		
	elif health<=20 and health>=1:
		$health/Label.hide()
		$health/Label2.hide()
		$health/Label3.hide()
		$health/Label4.hide()
		$health/Label5.show()
		
	elif health<=0:
		$health/Label.hide()
		$health/Label2.hide()
		$health/Label3.hide()
		$health/Label4.hide()
		$health/Label5.hide()

	
	if health<=0:
		ok_die = 1
		
	
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
	else: vel.x = lerp(vel.x,0,0.05)
	
	
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down") and is_on_floor():
		vel.y=0
	elif Input.is_action_pressed("ui_up") and is_on_floor():
		accel = leg_force
	else:
		vel.y = lerp(vel.z,0,0.1)
	
	if get_translation_delta().y == 0:
		accel = 0
	if Input.is_action_just_pressed("ui_rel") and (pistol.stop==0 and pistol.cant_shoot==0 and pistol.no_ammo == 0 and pistol.bullets_remaining>0):
		$walking.play("reload_pistol_hands") 
	accel += gravity*delta
	vel.y += accel
	physics_delta = delta
	
	
func _on_Area_body_entered(body):
	if(body.name == "prot") and is_on_floor():
		part.set_emitting(true)
		translate(at)
		print ("yeet1")


func _on_Area2_body_entered(body):	
	if(body.name == "prot") and is_on_floor():
		part2.set_emitting(true)
		translate(to)
		print("yeet2")





func _on_holster_time_timeout():
	pistol.start=1
	$holster_time.stop()
	




func _on_empty_mag_timeout():
	reload_hands=1







