extends Spatial

onready var Bullet = preload("res://scenes/bullet.tscn")
onready var Case = preload("res://scenes/bullet_case.tscn")
onready var Camera = get_node("/root/Spatial/InterpolatedCamera")
onready var Viewport = get_node("/root/Spatial/InterpolatedCamera/Viewport")
onready var Parent = get_parent()

onready var mouse_position = Vector3()

var bullet_spawn_location = Vector3()
var case_spawn_location = Vector3()

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("mouse_click"):
		var mouse_pos = get_tree().root.get_mouse_position()
		mouse_position = Vector3(mouse_pos.x, mouse_pos.y, 0)
		print(mouse_position)
		mouse_pos = Viewport.get_viewport().get_mouse_position()
		print(mouse_pos)
		shoot()



func shoot():
	# spawn bullet and case
	var bullet = Bullet.instance()
	var case = Case.instance()
	
	Parent.add_child(bullet)
	Parent.add_child(case)
	
	# get the required positions and translations
	var pos = Camera.unproject_position(get_global_transform().origin)
	print(pos)
	bullet_spawn_location = Vector3(pos.x, pos.y, 0)
	case_spawn_location = Vector3(pos.x, pos.y, 0)
	
	var bullet_translation_vector = translation
	var case_translation_vector = translation
	
	var bullet_speed_vector = mouse_position - bullet_spawn_location
	bullet_speed_vector.y *= -1
	
	bullet.global_rotate(Vector3(1, 0, 0), 300)
	bullet.set_speed(bullet_speed_vector.normalized())
	bullet.global_translate(bullet_translation_vector)
	
	case.global_rotate(Vector3(1, 0, 0), 300)
	case.global_translate(case_translation_vector)
	case.apply_impulse(Vector3(0, 0, 0), Vector3(0, 0, 1))
