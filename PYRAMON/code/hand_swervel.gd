extends Spatial

var ray_origin = Vector3()
var ray_target=Vector3()

onready var cam = get_node("/root/level/InterpolatedCamera")

func _physics_process(delta):
    var space_state = get_world().direct_space_state
    var ray = space_state.intersect_ray(ray_origin,ray_target,[self],1,true,true)
	
    if ray:
        var ray_collision_point = ray.position
        var object_position = get_translation()
        ray_collision_point = object_position-ray_collision_point
        var angle = Vector2(ray_collision_point.x,ray_collision_point.y).angle_to(Vector2(object_position.x,object_position.y))
        self.set_rotation(Vector3(angle,0,0))
		
func _input(event):

    if event is InputEventMouseMotion:
        ray_origin = cam.project_ray_origin(get_viewport().get_mouse_position())
        ray_target = cam.project_ray_normal(get_viewport().get_mouse_position())*1000
		
