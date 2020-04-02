extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var pause = get_parent().get_parent().get_node("pause")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_return_button_pressed():
	get_tree().paused = false
	get_parent().get_parent().remove_child(pause)
