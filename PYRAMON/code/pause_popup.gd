extends Popup
var exit=0
onready var main_menu = get_owner().get_node("main_menu_button")
onready var pause_settings = get_owner().get_node("PAUSE_SETTINGS_BUTTON")
func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		main_menu.set_disabled(false)
		pause_settings.set_disabled(false)
		popup()

func _on_pause_popup_popup_hide():
	pass