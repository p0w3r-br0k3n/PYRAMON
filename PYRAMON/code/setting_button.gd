extends TextureButton
onready var settings = preload("res://scenes/settings.tscn")
func _on_setting_button_pressed():
	get_tree().root.add_child(settings.instance())
