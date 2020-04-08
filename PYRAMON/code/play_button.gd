extends TextureButton
onready var map_picker = preload("res://scenes/map_picker.tscn")
onready var startui = get_node("/root/StartUI")

func _on_play_button_pressed():
	get_tree().root.add_child(map_picker.instance())
