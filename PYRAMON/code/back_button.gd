extends TextureButton

onready var settings = get_node("/root/Settings")
func _ready():
	pass

func _on_back_button_pressed():
	get_tree().root.remove_child(settings)
