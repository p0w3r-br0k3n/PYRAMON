extends OptionButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_item("1204x720", 0)
	add_item("1920x1080", 1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_OptionButton_item_selected(ID):
	if ID == 0:
		 OS.window_size=Vector2(1204 ,720)
	if ID ==  1:
		 OS.window_size=Vector2(1920 ,1080)
	print (OS.window_size)
