extends CanvasLayer

func _process(_delta):
	if Input.is_action_just_pressed("transformation"):
		$SelectionWheel.show()
	elif Input.is_action_just_released("transformation"):	
		var tool = $SelectionWheel.Close()
		$Label.text = "Player Transformation: " + tool
