extends TextureButton
onready var pause_set = get_owner().get_node("PAUSE_SETTINGS_BUTTON")
onready var pause = preload("res://scenes/pause.tscn")

func _ready():
	pass

func _on_back_button_pressed():
	get_tree().change_scene("res://scenes/startui.tscn")
	var num = pause_set.get_pause_set()
	if num == 1:
		get_tree().change_scene("res://scenes/1st_stage.tscn")
		
