extends KinematicBody

var target
func _process(delta):
	if target:
		look_at(target.global_trasform.origin, Vector3.UP)
	
func _on_Area_body_entered(body):
	if body.is_in_group("prot"):
		target= body
		print(1)


func _on_Area_body_exited(body):
	if body.is_in_group("prot"):
		target= null
		print(2)
