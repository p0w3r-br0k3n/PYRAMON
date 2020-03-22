extends Popup
func _ready():
	if Input.is_action_pressed("ui_cancel"):
		popup()
	