extends Spatial
onready var play_res= get_tree().get_root().get_node("/root/level/prot/")
onready var pause = preload("res://scenes/pause.tscn")
onready var player = preload("res://scenes/protagonist.tscn")
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		
			if not has_node("pause"):
				add_child(pause.instance())
				get_tree().paused = true

	if play_res.ok_die==1:
		play_res.ok_die=0