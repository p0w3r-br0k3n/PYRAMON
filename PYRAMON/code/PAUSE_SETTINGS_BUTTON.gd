extends Button

onready var settings = preload("res://scenes/settings.tscn")

var pause_set=0
func get_pause_set():
	return pause_set

func _on_PAUSE_SETTINGS_BUTTON_pressed():
	get_tree().root.add_child(settings.instance())
	pause_set = 1