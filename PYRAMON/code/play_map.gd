extends TextureButton
onready var lets_a_go = get_node("/root/map_picker/lets_a_go_desc")

func _ready():
	pass

func _on_play_map_pressed():
	var num = lets_a_go.get_let_go()
	if num == 1:
		get_tree().change_scene("res://scenes/1st_stage.tscn")
