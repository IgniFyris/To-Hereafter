extends Area2D

var test_mem: PackedScene = preload("uid://bu5fod7l4q240")

# Soul 2
var soul2_mem: PackedScene = preload("uid://br02tyeel23dp")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GlobalVars.memoryAmt += 1
		if GlobalVars.current_scene == "Soul2":
			if GlobalVars.memoryAmt == 1:
				get_parent().playerCam.enabled = false
				var soul2Mem = soul2_mem.instantiate()
				get_parent().Canvaslayer.call_deferred("add_child", soul2Mem)
				get_parent().SanityBar.visible = false
			elif GlobalVars.memoryAmt == 2:
				if GlobalVars.current_scene == "Soul2":
					get_parent().playerCam.enabled = false
					var soul2Mem = soul2_mem.instantiate()
					get_parent().Canvaslayer.call_deferred("add_child", soul2Mem)
					get_parent().SanityBar.visible = false
			elif GlobalVars.memoryAmt == 3:
				if GlobalVars.current_scene == "Soul2":
					get_parent().playerCam.enabled = false
					var soul2Mem = soul2_mem.instantiate()
					get_parent().Canvaslayer.call_deferred("add_child", soul2Mem)
					get_parent().SanityBar.visible = false
			elif GlobalVars.memoryAmt == 4:
				if GlobalVars.current_scene == "Soul2":
					get_parent().playerCam.enabled = false
					var soul2Mem = soul2_mem.instantiate()
					get_parent().Canvaslayer.call_deferred("add_child", soul2Mem)
					get_parent().SanityBar.visible = false
		get_tree().paused = true
		call_deferred("queue_free")
