extends Label

onready var bullets_rem = get_node("/root/level/prot/hand_swervel/hand_right/scene_root")
func _process(delta):
   text=String( bullets_rem.reload)
   if bullets_rem.bullets_remaining <-9:
												text= String(0)