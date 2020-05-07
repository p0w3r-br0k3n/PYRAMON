extends Control
onready var he = get_tree().get_root().get_node("/root/level/prot")
func _proces(delta):
	if he.health<=100 and he.health>=81:
		$Label.show()
		
	elif he.health<=80 and he.health>=61:
		$health/Label.hide()
		$health/Label2.show()
	
	elif he.health<=60 and he.health>=41:
		$health/Label.hide()
		$health/Label2.hide()
		$health/Label3.show()
	elif he.health<=40 and he.health>=21:
		$health/Label.hide()
		$health/Label2.hide()
		$health/Label3.hide()
		$health/Label4.visible=true
		
	elif he.health<=20 and he.health>=1:
		$health/Label.hide()
		$health/Label2.hide()
		$health/Label3.hide()
		$health/Label4.hide()
		$health/Label5.show()
		
	elif he.health<=0:
		$health/Label.hide()
		$health/Label2.hide()
		$health/Label3.hide()
		$health/Label4.hide()
		$health/Label5.hide()