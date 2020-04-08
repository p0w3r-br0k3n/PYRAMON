extends Spatial

onready var Bullet = preload("res://scenes/bullet.tscn")
onready var Case = preload("res://scenes/bullet_case.tscn")
onready var Sound = $pistol_gun_sound_source
onready var Smoke = $smoke_pistol
onready var Camera = get_node("/root/level/InterpolatedCamera")
var clip= 1
var start = 0
var stop = 0
onready var Parent = get_parent()

onready var fire_timer = null
onready var smoke_timer = null
onready var fire_delay = 0.5
onready var smoke_delay = 2
onready var can_smoke = false
var bullets_remaining = 120

onready var mouse_position = Vector3()

var bullet_spawn_location = Vector3()
var case_spawn_location = Vector3()
var reload = 9

func _ready():
	fire_timer = Timer.new()
	smoke_timer = Timer.new()
	
	fire_timer.connect("timeout", self, "fire_timeout_complete")
	smoke_timer.connect("timeout", self, "smoke_timeout_complete")
	
	fire_timer.set_wait_time(fire_delay)
	smoke_timer.set_wait_time(smoke_delay)
	
	add_child(fire_timer)
	add_child(smoke_timer)

func _process(delta):
	if Input.is_action_just_pressed("mouse_click") and stop==0 or start == 1:
		var mouse_pos = get_tree().root.get_mouse_position()
		mouse_position = Vector3(mouse_pos.x, mouse_pos.y, 0)
		$fire_pistol.set_emitting(true)
		$fire_pistol/fire_pistol_time.start()
		shoot()
	#reloading
	if Input.is_action_just_pressed("ui_rel"):
		$AnimationPlayer.play("basic_gun_reload")
		$pistol_reload_sound.play()
		bullets_remaining=bullets_remaining-clip
		$Cube/Cube005/cube5_time.start()
		$reload.start()
		bullets_remaining = bullets_remaining-clip
		print(bullets_remaining)
	if reload == 9:
		clip=0
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
	if(reload == 0 and stop == 0):
		stop=1
		$Cube/Cube005/cube5_time.start()
		$reload.start()
		$AnimationPlayer.play("basic_gun_reload")
		$pistol_reload_sound.play()
		$fire_pistol.set_emitting(false)
		bullets_remaining= bullets_remaining-9
		$empty_mag.start()
		
		
		# here we would probably add some reload function
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
	var pos = Camera.unproject_position(get_global_transform().origin)
	print(pos)
	
	bullet_spawn_location = Vector3(pos.x, pos.y, 0)
	
	# we should realistically have two separate nodes for 
	# bullet translation and case translation so they don't collide as soon as they spawn
	# temp fix
	var bullet_translation_vector = Vector3(translation.x + 0.2, translation.y, translation.z)
	var case_translation_vector = translation
	
	var bullet_speed_vector = mouse_position - bullet_spawn_location
	bullet_speed_vector.y *= -1
	
	bullet.global_rotate(Vector3(1, 0, 0), 300)
	bullet.set_speed(bullet_speed_vector.normalized())
	bullet.global_translate(bullet_translation_vector)
	
	case.global_rotate(Vector3(1,0,0),300)
	case.global_translate(case_translation_vector.normalized())
	case.apply_impulse(Vector3(0,0,0), Vector3(0,0,1))
	reload = reload - 1
	
	clip= clip+0.5
	
	fire_timer.start()
	stop = 0

func _on_fire_pistol_time_timeout():
	$fire_pistol.set_emitting(false)
	$fire_pistol/fire_pistol_time.stop()





func _on_cube5_time_timeout():
	$Cube/Cube005.hide()
	$Cube/Cube005/cube5_time_2.start()
	$Cube/Cube005/cube5_time.stop()
	


func _on_cube5_time_2_timeout():
	$Cube/Cube005.show()
	$Cube/Cube005/cube5_time_2.stop()
	


func _on_reload_timeout():
	reload = 9
	print(reload)
	$reload.stop()
	
	




	

func _on_empty_mag_timeout():
	start = 1
	$empty_mag.stop()
