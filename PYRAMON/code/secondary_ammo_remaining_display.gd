extends Control
var holster=0
func _process(delta):
	
	if Input.is_action_just_pressed("1"):
		if holster== 0:
			$Timer.start()
			
		elif holster==1:
			$Timer2.start()


func _on_Timer_timeout():
	$Label.show()
	holster=1
	$Timer.stop()

func _on_Timer2_timeout():
	$Label.hide()
	holster=0
	$Timer2.stop()
	
