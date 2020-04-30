extends Label

onready var bullets_rem = get_node("/root/pistol_root")
func _ready():
   print(bullets_rem."bullets_remaining")