extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("transformation"):
		$SelectionWheel.show()
	elif Input.is_action_just_released("transformation"):	
		$SelectionWheel.Close()
		
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
