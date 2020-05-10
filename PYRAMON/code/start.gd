extends Node2D

func _ready():
	$VideoPlayer.play()
	$Timer.start()
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/startui.tscn")
func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/startui.tscn")