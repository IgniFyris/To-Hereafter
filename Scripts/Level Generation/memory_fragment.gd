extends Area2D

var test_mem: PackedScene = preload("uid://bu5fod7l4q240")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GlobalVars.memoryAmt += 1
		if GlobalVars.current_scene == "LevelGeneration":
			if GlobalVars.memoryAmt == 1:
				get_parent().playerCam.enabled = false
				var testMem = test_mem.instantiate()
				get_parent().Canvaslayer.call_deferred("add_child", testMem)
				get_parent().SanityBar.visible = false
			elif GlobalVars.memoryAmt == 2:
				pass
			elif GlobalVars.memoryAmt == 3:
				pass
			elif GlobalVars.memoryAmt == 4:
				pass
		get_tree().paused = true
		call_deferred("queue_free")
