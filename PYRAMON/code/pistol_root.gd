extends Spatial
onready var Mag = preload("res://scenes/pistol_magazine.tscn")
onready var Bullet = preload("res://scenes/bullet.tscn")
onready var Case = preload("res://scenes/bullet_case.tscn")
onready var Sound = $pistol_gun_sound_source
onready var Smoke = $smoke_pistol
onready var Camera = get_node("/root/level/InterpolatedCamera")
var clip= 1
var start = 1
var stop = 0
var cant_shoot= 0
var cant_shoot_animation_stop=0
onready var Parent = get_parent().get_parent().get_parent()
var stop_fire_holster=0
var stop_click_holster = 0
onready var fire_timer = null
onready var smoke_timer = null
onready var fire_delay = 0.5
onready var smoke_delay = 2
onready var can_smoke = false


onready var mouse_position = Vector3()

var bullet_spawn_location = Vector3()
var case_spawn_location = Vector3()
var reload = 9
var no_ammo=0

var bullets_remaining = 9
	
func _ready():
	fire_timer = Timer.new()
	smoke_timer = Timer.new()
	
	fire_timer.connect("timeout", self, "fire_timeout_complete")
	smoke_timer.connect("timeout", self, "smoke_timeout_complete")
	
	fire_timer.set_wait_time(fire_delay)
	smoke_timer.set_wait_time(smoke_delay)
	
	add_child(fire_timer)
	add_child(smoke_timer)


# warning-ignore:unused_argument
func _process(delta):
	
	if Input.is_action_just_pressed("mouse_click") and no_ammo==1:
			$no_more_ammo.play(true)
			
	
	
	
	if Input.is_action_just_pressed("mouse_click") and (stop==0 or start == 1 and cant_shoot==0 and bullets_remaining>-9):
		var mouse_pos = get_tree().root.get_mouse_position()
		mouse_position = Vector3(mouse_pos.x, mouse_pos.y, 0)
		
		$fire_pistol.set_emitting(true)
		$fire_pistol/fire_pistol_time.start()
		shoot()
	#reloading
	if Input.is_action_just_pressed("ui_rel") and (stop==0 and cant_shoot==0 and no_ammo == 0):
		var mag= Mag.instance()
	
	
		Parent.add_child(mag)
		var mag_translation_vector = global_transform.origin
		start = 0
		stop=1
		$AnimationPlayer.play("basic_gun_reload")
		$pistol_reload_sound.play()
		bullets_remaining=bullets_remaining-clip
		
		$reload.start()
		bullets_remaining = bullets_remaining-clip
		print(bullets_remaining)
		$empty_mag.start()
		print (bullets_remaining)
		mag.global_rotate(Vector3(1,0,0),300)
		mag.global_translate(mag_translation_vector)
		mag.apply_impulse(Vector3(0,0,0), Vector3(0,0,1))
		
	if Input.is_action_just_pressed("ui_rel") and (stop==0 and cant_shoot==0 and no_ammo == 0 and bullets_remaining<=0):
		reload= reload+bullets_remaining
	if reload == 9:
		clip=0
	if  bullets_remaining==-9:
		
		no_ammo=1
		
		
		
	if (cant_shoot==1 and cant_shoot_animation_stop==0 ):
		$AnimationPlayer.play("pistol_empty")
		cant_shoot_animation_stop=1
		
		

func smoke_timeout_complete():
	Smoke.set_emitting(false)
	smoke_timer.stop()

func fire_timeout_complete():
	print("hwat")
	Smoke.set_emitting(true)
	smoke_timer.start()
	fire_timer.stop()

func shoot():
	# check if we have ammo
	if(reload == 0 and stop == 0 and cant_shoot==0 ):
		start = 0
		stop=1
		if no_ammo==0:
				$pistol_reload_sound.play()
				
		elif no_ammo==1:
			cant_shoot =1
			
	
		$reload.start()
		$AnimationPlayer.play("basic_gun_reload")
		
		$fire_pistol.set_emitting(false)
		bullets_remaining= bullets_remaining - 9
		$empty_mag.start()
		
		return
	
	# play bullet sound
	Sound.play()
	Smoke.set_emitting(false)
	
	# plays recoil animation
	$AnimationPlayer.play("basic_gun_recoil")
	
	# spawn bullet and case
	var bullet = Bullet.instance()
	var case = Case.instance()
	
	Parent.add_child(bullet)
	Parent.add_child(case)
	
	# get the required positions and translations
	var pos = Camera.unproject_position(global_transform.origin)
	
	bullet_spawn_location = Vector3(pos.x, pos.y, 0)
	
	# we should realistically have two separate nodes for 
	# bullet translation and case translation so they don't collide as soon as they spawn
	# temp fix
	var bullet_translation_vector = Vector3(global_transform.origin.x +0.2,global_transform.origin.y, global_transform.origin.z)
	var case_translation_vector = global_transform.origin
	
	var bullet_speed_vector = mouse_position - bullet_spawn_location
	bullet_speed_vector.y *= -1
	
	bullet.global_rotate(Vector3(1, 0, 0), 300)
	bullet.set_speed(bullet_speed_vector.normalized())
	bullet.global_translate(bullet_translation_vector)
	
	case.global_rotate(Vector3(1,0,0),300)
	case.global_translate(case_translation_vector)
	case.apply_impulse(Vector3(0,0,0), Vector3(0,0,1))
	reload = reload - 1
	clip=clip+1
	
	fire_timer.start()
	stop = 0

func _on_fire_pistol_time_timeout():
	$fire_pistol.set_emitting(false)
	$fire_pistol/fire_pistol_time.stop()


func _on_reload_timeout():
	reload = 9
	print(reload)
	$reload.stop()

func _on_empty_mag_timeout():
	start = 1
	$empty_mag.stop()


