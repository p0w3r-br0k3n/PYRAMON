extends CanvasLayer

var smooth_preloads = []

func _ready():
	smooth_preloads.push_back("res://scenes/bullet.tscn")
	smooth_preloads.push_back("res://scenes/bullet_case.tscn")
	smooth_preload()

func smooth_preload():
	for path in smooth_preloads:
		var t = load(path).instance()
		add_child(t)
		yield(get_tree(), "idle_frame")