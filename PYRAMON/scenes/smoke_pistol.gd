extends Particles
func _process(delta):
	if Input.is_action_just_pressed("mouse_click"):
		emitting=true
		print("op")
	
