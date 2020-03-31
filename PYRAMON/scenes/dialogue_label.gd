extends Popup

var next = 0
func get_next():
	return next
func _on_next_button_pressed():
	next =next + 1
	if next == 1:
		popup()
