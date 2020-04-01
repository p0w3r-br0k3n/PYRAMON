extends TextureButton


onready var starti = get_node("/root/map_picker")

func _on_back_map_picker_pressed():
	get_tree().change_scene("res://scenes/startui.tscn")
	get_tree().root.remove_child(starti)

