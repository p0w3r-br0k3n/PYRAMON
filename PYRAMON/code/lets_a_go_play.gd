extends Popup
var let_go = 0

func get_let_go():
	return let_go

func _on_lets_a_go_pressed():
	popup()
	let_go = 1