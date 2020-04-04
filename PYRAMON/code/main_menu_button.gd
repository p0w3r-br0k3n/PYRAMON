extends Button
onready var map = preload("res://scenes/startui.tscn")
onready var stage = get_node("/root/level")

func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().root.add_child(map.instance())
	get_tree().root.remove_child(stage)
	stage.queue_free()
