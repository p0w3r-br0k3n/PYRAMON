extends Spatial

onready var pause = preload("res://scenes/pause.tscn")

func _ready():
	pass 

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") :
			if not has_node("pause"):
				add_child(pause.instance())
				get_tree().paused = true