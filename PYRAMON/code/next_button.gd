extends TextureButton

onready var next = get_owner().get_node("dialogue_label").get_next()
func _on_next_button_pressed():
	next= next+1
	if next==7:
		get_tree().change_scene("res://scenes/1st_stage.tscn")
