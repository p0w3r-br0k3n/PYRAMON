extends Spatial

func _ready():
	pass # Replace with function body.

func shoot():
	print("BAM!");
	get_node("AnimationPlayer").stop(1)
	get_node("AnimationPlayer").play("basic_gun_recoil")
