extends Label
onready var hea = get_tree().get_root().get_node("/root/level/prot")
func _process(delta):
	text= String (hea.health)