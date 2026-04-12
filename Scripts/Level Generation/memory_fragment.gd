extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GlobalVars.memoryAmt += 1
		if GlobalVars.current_scene == "LevelGenerations":
			if GlobalVars.memoryAmt == 1:
				pass # instantiate first scene
			elif GlobalVars.memoryAmt == 2:
				pass
			elif GlobalVars.memoryAmt == 3:
				pass
			elif GlobalVars.memoryAmt == 4:
				pass
		queue_free()
