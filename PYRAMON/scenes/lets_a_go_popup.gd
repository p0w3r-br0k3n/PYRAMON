extends Popup
var lets_a_go = 0

func get_let_go():
	return lets_a_go

func _on_lets_a_go_pressed():
	popup()
	lets_a_go = 1
