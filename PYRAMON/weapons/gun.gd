extends Spatial

onready var Bullet = preload("res://scenes/bullet.tscn")
onready var Case = preload("res://scenes/bullet_case.tscn")
onready var Sound = $pistol_gun_sound_source
onready var Smoke = $smoke_pistol
onready var Camera = get_node("/root/Spatial/InterpolatedCamera")

onready var Parent = get_parent()

onready var timer = null
onready var smoke_delay = 0.35
onready var can_smoke = false

onready var mouse_position = Vector3()

var bullet_spawn_location = Vector3()
var case_spawn_location = Vector3()
var reload = 9

func _ready():
	timer = Timer.new()
	timer.connect("timeout", self, "timeout_complete")
	timer.set_wait_time(smoke_delay)
	add_child(timer)

func _process(delta):
	if Input.is_action_just_pressed("mouse_click"):
		var mouse_pos = get_tree().root.get_mouse_position()
		mouse_position = Vector3(mouse_pos.x, mouse_pos.y, 0)
		shoot()

func timeout_complete():
	Smoke.set_emitting(true)

func shoot():
	
	# plays recoil animation
	$AnimationPlayer.play("basic_gun_recoil")
	# check if we have ammo
	if(reload == 0):
		$AnimationPlayer.play("basic_gun_reload")
		# here we would probably add some reload function
		#plays pistol reload sound
		$pistol_reload_sound.play()
		
		return
	# play bullet sound
	Sound.play()
	Smoke.set_emitting(false)
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
	var bullet_translation_vector = Vector3(translation.x + 0.1, translation.y, translation.z)
	var case_translation_vector = translation
	
	var bullet_speed_vector = mouse_position - bullet_spawn_location
	bullet_speed_vector.y *= -1
	
	bullet.global_rotate(Vector3(1, 0, 0), 300)
	bullet.set_speed(bullet_speed_vector.normalized())
	bullet.global_translate(bullet_translation_vector)
	
	case.global_rotate(Vector3(1, 0, 0), 300)
	case.global_translate(case_translation_vector)
	case.apply_impulse(Vector3(0, 0, 0), Vector3(0, 0, 1))
	
	reload = reload - 1
	timer.start()
