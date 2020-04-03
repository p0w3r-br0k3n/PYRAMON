extends Button

onready var pause = get_parent().get_parent().get_node("pause")

func _on_return_button_pressed():
	get_tree().paused = false
	get_parent().get_parent().remove_child(pause)
