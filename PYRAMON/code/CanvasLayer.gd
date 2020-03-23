extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var smooth_preloads = []
# Called when the node enters the scene tree for the first time.
func _ready():
	smooth_preloads.push_back("res://scenes/bullet.tscn")
	smooth_preloads.push_back("res://scenes/bullet_case.tscn")
	smooth_preload()

func smooth_preload():
	for path in smooth_preloads:
		var t = load(path).instance()
		add_child(t)
		yield(get_tree(), "idle_frame")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
