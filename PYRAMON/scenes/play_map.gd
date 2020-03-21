extends TextureButton
onready var lets_a_go = get_node("lets_a_go_desc")

func _ready():
    pass

func _on_play_map_pressed():
		if lets_a_go.get_let_go == 1:
			get_tree().change_scene("res://scenes/1st_stage.tscn")