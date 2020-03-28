extends Popup
var exit=0

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		popup()
	