extends TextureButton


func _on_play_button_pressed():
	get_tree().change_scene("res://scenes/map_picker.tscn")