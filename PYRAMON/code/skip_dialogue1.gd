extends Control
onready var dialogue = get_node("/root/dialogue")
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/1st_stage.tscn")
		get_tree().root.remove_child(dialogue)