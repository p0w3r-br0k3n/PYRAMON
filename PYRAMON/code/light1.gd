extends MeshInstance

func _ready():
	$Timer.start()

func _on_Timer_timeout():
	$OmniLight.hide()
	$Timer.stop()
	$Timer2.start()

func _on_Timer2_timeout():
	$OmniLight.show()
	$Timer2.stop()
	$Timer.start()
