extends Button

var pause_set=0
func get_pause_set():
	return pause_set


func _on_PAUSE_SETTINGS_BUTTON_pressed():
	get_tree().change_scene("res://scenes/settings.tscn")
	pause_set = 1