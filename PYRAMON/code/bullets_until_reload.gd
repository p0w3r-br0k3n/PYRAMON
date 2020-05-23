extends Label

onready var bullets_rem = get_node("/root/level/prot/hand_swervel/hand_right/scene_root")
func _process(delta):
   text=String( bullets_rem.reload)
   if bullets_rem.no_ammo==1:
												text= String(0)
