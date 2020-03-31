extends TextureButton
onready var lets_a_go = get_node("/root/map_picker/lets_a_go_desc")
onready var map = preload("res://scenes/dialogue.tscn")
onready var map_picker = get_node("/root/map_picker")

func _ready():
	pass

func _on_play_map_pressed():
	var num = lets_a_go.get_let_go()
	if num == 1:
		get_tree().root.add_child(map.instance())
		get_tree().root.remove_child(map_picker)
		map_picker.queue_free()
