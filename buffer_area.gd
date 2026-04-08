extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("transformation"):
		$SelectionWheel.show()
	elif Input.is_action_just_released("transformation"):	
		$SelectionWheel.Close()
