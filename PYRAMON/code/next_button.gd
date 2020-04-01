extends TextureButton
onready var dialogue = get_node("/root/dialogue")

func _on_next_button_pressed():
	var next = get_owner().get_node("dialogue_label").get_next()
	if next==8:
		get_tree().change_scene("res://scenes/1st_stage.tscn")
		get_tree().root.remove_child(dialogue)
