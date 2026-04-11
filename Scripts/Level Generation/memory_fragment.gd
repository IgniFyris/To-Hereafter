extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.memoryAmt += 1
		if GlobalVars.current_scene == "LevelGenerations":
			if body.memoryAmt == 1:
				pass # instantiate first scene
			elif body.memoryAmt == 2:
				pass
			elif body.memoryAmt == 3:
				pass
			elif body.memoryAmt == 4:
				pass
		queue_free()
