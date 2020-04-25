extends Label

var bullets = 3
var bullets_on_clip=0
var clip =0

func _ready():
	text = String(bullets)
	
	if Input.is_action_just_pressed("mouse_click"):
		bullets_on_clip = bullets_on_clip+1
		clip=clip+1
	
	if Input.is_action_just_pressed("r"):
		bullets = bullets - clip
		
	if bullets_on_clip==9:
		bullets= bullets-9
	if bullets <0:
		bullets=0