extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var pause = preload("res://scenes/pause.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if not has_node("pause"):
			add_child(pause.instance())
			get_tree().paused = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
